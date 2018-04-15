defmodule KV.Store do
  use GenServer

  def start_link(worker_id) do
    GenServer.start_link(__MODULE__, :ok, name: via(worker_id))
  end

  defp via(key), do: {:via, KV.Registry, {__MODULE__, key}}

  @impl GenServer
  def init(:ok) do
    {:ok, %{}}
  end

  def get(name, key) do
    GenServer.call(via(name), {:get, key})
  end

  def put(name, key, value) do
    GenServer.cast(via(name), {:put, key, value})
  end

  @impl GenServer
  def handle_call({:get, key}, _timeout, state) do
    result = Map.get(state, key, :undefined)
    {:reply, result, state}
  end

  @impl GenServer
  def handle_cast({:put, key, value}, state) do
    state = Map.put(state, key, value)
    {:noreply, state}
  end
end
