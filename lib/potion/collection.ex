defmodule Potion.Collection do
  @doc """
  ## Examples
  """
  @spec get(any, any, any) :: any
  def get(list, key, default) when is_list(list) do
    Enum.at(list, key, default)
  end

  def get(map, key, default) when is_map(map) do
    Map.get(map, key, default)
  end

  def get(tuple, key, default)  when is_tuple(tuple) do
    tuple |> Tuple.to_list() |> Enum.at(key, default)
  end

  def get(data, _key, _default) do
    data
  end
end