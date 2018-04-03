defmodule KV do
  use Application

  def start(_type, _args) do
    KV.Overlord.start_link(name: KV.Overlord)
  end
end
