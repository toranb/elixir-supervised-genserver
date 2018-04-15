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

  def get(worker_id, key) do
    GenServer.call(via(worker_id), {:get, worker_id, key})
  end

  def put(worker_id, key, value) do
    GenServer.cast(via(worker_id), {:put, worker_id, key, value})
  end

  @impl GenServer
  def handle_call({:get, worker_id, key}, _timeout, state) do
    result = KV.Store.get(worker_id, key)
    {:reply, result, state}
  end

  @impl GenServer
  def handle_cast({:put, worker_id, key, value}, state) do
    KV.Store.put(worker_id, key, value)
    {:noreply, state}
  end
end
