defmodule Ping do
  def loop do
    receive do
      {sender_pid, :ping} ->
        send sender_pid, :pong
        Process.sleep(10)

      _ ->
        IO.puts "Error"
    end
    loop()
  end
end

defmodule Pong do
  def loop do
    receive do
      {sender_pid, :pong} ->
        send sender_pid, :ping
        Process.sleep(10)

      _ ->
        IO.puts "Error"
    end
    loop()
  end
end


defmodule Main do
  def run do
    ping_id = spawn(Ping, :loop, [])
    pong_id = spawn(Pong, :loop, [])

    1..10 |> Enum.each(fn _ ->
      send ping_id, {self(), :ping}
      send pong_id, {self(), :pong}
    end)
  end
end

IO.puts "Hello world"
