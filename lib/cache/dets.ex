defmodule ElixirCache.Cache.Dets do
  use GenServer
  @table :dets_cache

  def start_link(_opts) do
    IO.inspect("starting the DETS Genserver")
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(state) do

    case :dets.open_file(@table,
           type: :set,
           file: ~c"cache/#{@table}.dets"
         ) do
      {:ok, _table} ->
        {:ok, state}

      {:error, reason} ->
        {:stop, reason}
    end
  end

  @impl true
  def terminate(_reason, _state) do
    :dets.close(@table)
    :ok
  end

  def put(key, value) do
    :dets.insert(@table, {key, value})
  end

  def get(key) do
    case :dets.lookup(@table, key) do
      [{^key, value}] ->
        {:ok, value}

      [] ->
        :error
    end
  end

  def all do
    :dets.foldl(
      fn record, acc ->
        [record | acc]
      end,
      [],
      @table
    )
  end

  def delete(key) do
    :dets.delete(@table, key)
  end
end
