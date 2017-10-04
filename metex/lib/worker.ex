defmodule Metex.Worker do
  def loop do
    receive do
      {sender_pid, location} ->
        send sender_pid, {:ok, temperature_of(location)}

      _ ->
        IO.puts "Not sure what's going on here!"
    end
    loop()
  end


  def temperature_of(location) do
    result =
      url_for(location)
      |> HTTPoison.get()
      |> parse_response
    case result do
      {:ok, temp} ->
        "#{location}: #{temp}°C"

      :error ->
        "#{location} not found"
    end
  end


  def url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey()}"
  end


  def parse_response({:ok,
                      %HTTPoison.Response{body: body, status_code: 200}}) do
    body
    |> JSON.decode!()
    |> compute_temperature
  end

  def parse_response(_) do
    :error
  end


  def compute_temperature(json) do
    try do
      temp =
        json["main"]["temp"] - 273.15
        |> Float.round(1)
      {:ok, temp}
    rescue
      _ ->
        :error
    end
  end


  defp apikey do
    "875d7d9fc78f7f08b691df860fce2711"
  end
end
