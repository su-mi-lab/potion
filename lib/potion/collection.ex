defprotocol Potion.Collection do
  @spec get(any, String.t | Integer.t | Atom.t, any) :: any
  def get(data, key, default)
end

defimpl Potion.Collection, for: List do
  def get(list, key, default) do
    Enum.at(list, key, default)
  end
end

defimpl Potion.Collection, for: Map do
  def get(map, key, default) do
    Map.get(map, key, default)
  end
end

defimpl Potion.Collection, for: Tuple do
  def get(tuple, key, default) do
    tuple |> Tuple.to_list() |> Enum.at(key, default)
  end
end

defimpl Potion.Collection, for: Any do
  def get(data, _key, _default) do
    data
  end
end