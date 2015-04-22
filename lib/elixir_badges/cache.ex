defmodule ElixirBadges.Cache do
  use GenServer

  # This server is intended to store keys for a value.
  # The given timeout is in seconds, and a entry will NOT
  # be deleted afterwards. It is seen as stale which can be
  # better then :notfound.

  #--- Public API

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def set(key, value, timeout \\ 10) when timeout > 0 do
    GenServer.call(__MODULE__, {:set, key, value, timeout})
  end

  #--- Implementation

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, [name: __MODULE__])
  end

  def handle_call({:get, key}, _from, map) do
    case fetch_value(map, key) do
      {:notfound, map, nil}   -> {:reply, :notfound, map}
      {:ok, map, value} -> {:reply, {:value, value}, map}
      {:timeout, map, value} -> {:reply, {:value_timeout, value}, map}
    end
  end

  def handle_call({:set, key, value, timeout}, _from, map) do
    {:reply, :ok, Dict.put(map, key, [value: value, timeout_ts: (current_ts + timeout)])}
  end

  defp fetch_value(map, key) do
    if Dict.has_key?(map, key) do
      [value: value, timeout_ts: ts] = Dict.get(map, key)
      if ts <= current_ts do
        {:timeout, map, value}
      else
        {:ok, map, value}
      end
    else
      {:notfound, map, nil}
    end
  end

  defp current_ts do
    {ms, s, _} = :os.timestamp
    (ms * 1_000_000 + s)
  end
end
