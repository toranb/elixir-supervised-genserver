defmodule KV.Supervisor do
  @pool_size 3

  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = Enum.map(1..@pool_size, &worker_spec/1)
    Supervisor.init(children, strategy: :one_for_one)
  end

  defp worker_spec(worker_id) do
    default_worker_spec = {KV.Bucket, worker_id}
    Supervisor.child_spec(default_worker_spec, id: worker_id)
  end
end
