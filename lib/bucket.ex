defmodule KV.Bucket do
  use GenServer

  def start_link(worker_id) do
    GenServer.start_link(__MODULE__, :ok, name: {:via, :global, worker_id})
  end

  def init(:ok) do
    {:ok, nil}
  end

  def get(name, key) do
    KV.Store.get(key)
  end

  def put(name, key, value) do
    KV.Store.put(key, value)
  end
end
