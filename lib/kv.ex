defmodule KV do
  use Application

  def start(_type, _args) do
    KV.Bucket.start_link(name: KV.Bucket)
  end
end
