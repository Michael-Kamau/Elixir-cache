defmodule ElixirCache.Cache.Ets do
  @table :global_cache

  def start do
    :ets.new(@table, [
      :named_table,
      :public,
      :set,
      read_concurrency: true
    ])
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
