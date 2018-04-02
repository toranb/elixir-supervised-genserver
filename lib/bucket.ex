defmodule KV.Bucket do
  use GenServer

  def start_link(worker_id) do
    GenServer.start_link(__MODULE__, :ok, name: {:via, :global, worker_id})
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

  def delete(name, key) do
    GenServer.cast(name, {:delete, key})
  end

  def handle_cast({:put, key, value}, state) do
    state = Map.put(state, key, value)
    {:noreply, state}
  end

  def handle_cast({:delete, key}, state) do
    {_key, state} = Map.pop(state, key)
    {:noreply, state}
  end

  def handle_call({:get, key}, _timeout, state) do
    result = Map.get(state, key, :undefined)
    {:reply, result, state}
  end
end
