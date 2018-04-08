defmodule KV.Registry do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, name: :registry)
  end

  def whereis_name(name) do
    GenServer.call(:registry, {:whereis_name, name})
  end

  def register_name(name, pid) do
    GenServer.call(:registry, {:register_name, name, pid})
  end

  @impl GenServer
  def init(:ok) do
    {:ok, %{}}
  end

  def send(name, message) do
    case whereis_name(name) do
      :undefined ->
        {:badarg, {name, message}}

      pid ->
        Kernel.send(pid, message)
        pid
    end
  end

  @impl GenServer
  def handle_call({:whereis_name, name}, _timeout, state) do
    {:reply, Map.get(state, name, :undefined), state}
  end

  @impl GenServer
  def handle_call({:register_name, name, pid}, _timeout, state) do
    if Map.has_key?(state, name) do
      {:reply, :no, state}
    else
      Process.monitor(pid)
      {:reply, :yes, Map.put(state, name, pid)}
    end
  end

  @impl GenServer
  def handle_info({:DOWN, _, :process, pid, _}, state) do
    {:noreply, remove_pid(state, pid)}
  end

  def remove_pid(state, pid_to_remove) do
    remove = fn {_key, pid} -> pid  != pid_to_remove end
    Enum.filter(state, remove) |> Enum.into(%{})
  end

end
