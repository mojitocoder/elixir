defmodule Cache do
  use GenServer

  @name Singleton

  ## ===========
  ## Client API
  ## ===========
  def start_link(opts \\ []) do
    GenServer.start_link __MODULE__, :ok, opts ++ [name: Singleton]
  end

  def hello do
    :world
  end

  def write(key, term) do
    GenServer.cast @name, {:write, key, term}
  end

  def read(key) do
    GenServer.call @name, {:read, key}
  end

  def delete(key) do
    GenServer.cast @name, {:delete, key}
  end

  def clear do
    GenServer.cast @name, :clear
  end

  def exist?(key) do
    GenServer.call @name, {:exist?, key}
  end

  ## ===========
  ## Server Callbacks
  ## ===========
  def init(:ok) do
    # Initialise the beginning state
    # with an empty dictionary
    {:ok, %{}}
  end

  def handle_call({:read, key}, _from, dic) do
    term = read_dictionary(dic, key)
    {:reply, term, dic}
  end

  def handle_call({:exist?, key}, _from, dic) do
    val = exist_dictionary?(dic, key)
    {:reply, val, dic}
  end

  def handle_cast({:write, key, term}, dic) do
    new_dic = add_dictionary(dic, key, term)
    {:noreply, new_dic}
  end


  def handle_cast({:delete, key}, dic) do
    new_dic = delete_dictionary(dic, key)
    {:noreply, new_dic}
  end

  def handle_cast(:clear, _dic) do
    {:noreply, %{}}
  end

  ## ===========
  ## Helper Functions
  ## ===========
  defp add_dictionary(old_dic, key, val) do
    # put_new: Puts the given value under key
    # unless the entry key already exists in map
    Map.put_new(old_dic, key, val)
  end

  defp read_dictionary(dic, key) do
    Map.get(dic, key)
  end

  defp delete_dictionary(dic, key) do
    Map.delete(dic, key)
  end

  defp exist_dictionary?(dic, key) do
    Map.has_key?(dic, key)
  end
end
