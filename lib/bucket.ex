defmodule KV.Bucket do
  use GenServer

  def start_link(worker_id) do
    GenServer.start_link(__MODULE__, :ok, name: via(worker_id))
  end

  defp via(key), do: {:via, KV.Registry, {__MODULE__, key}}

  @impl GenServer
  def init(:ok) do
    {:ok, nil}
  end

  def get(name, key) do
    GenServer.call(via(name), {:get, key})
  end

  def put(name, key, value) do
    GenServer.cast(via(name), {:put, key, value})
  end

  @impl GenServer
  def handle_call({:get, key}, _timeout, state) do
    result = KV.Store.get(999, key)
    {:reply, result, state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    KV.Store.put(999, key, value)
    {:noreply, state}
  end
end
