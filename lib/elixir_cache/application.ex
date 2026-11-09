defmodule ElixirCache.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirCache.Cache.Ets
    ]

    Supervisor.start_link(children,
      strategy: :one_for_one,
      name: ElixirCache.Supervisor
    )
  end
end
