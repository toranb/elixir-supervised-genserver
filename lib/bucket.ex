defmodule KV.Bucket do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, :ok, args)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def get(name, key) do
    GenServer.call(name, {:get, key})
  end

  def put(name, key, value) do
    GenServer.cast(name, {:put, key, value})
  end

  def handle_cast({:put, key, value}, state) do
    state = Map.put(state, key, value)
    {:noreply, state}
  end

  def handle_call({:get, key}, _timeout, state) do
    result = Map.get(state, key, :undefined)
    {:reply, result, state}
  end
end
