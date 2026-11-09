defmodule ElixirCache.Cache.Ets do

  use GenServer
  @table :ets_cache

  def start_link(_opts) do
    IO.inspect("The cache server has been started")
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do
    :ets.new(@table, [
      :named_table,
      :public,
      :set,
      read_concurrency: true
    ])

    {:ok, state}
  end

 def put(key, value) do
  :ets.insert(@table,{key, value})
 end


 def get(key) do
  case :ets.lookup(@table, key) do
    [{^key, value}] -> {:ok, value}
    [] -> :not_found
  end
 end

 def all do
  :ets.tab2list(@table)
 end

 def delete(key) do
  :ets.delete(@table, key)
 end


end
