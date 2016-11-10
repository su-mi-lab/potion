defprotocol Potion.Collection do
  @spec get(any, String.t | Integer.t | Atom.t, any) :: any
  def get(data, key, default)

  @spec trim(Map.t | List.t | Tuple.t) :: Map.t | List.t | Tuple.t
  def trim(data)

  @spec put(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put(data, item)

  @spec put_first(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put_first(data, item)
end

defimpl Potion.Collection, for: List do
  def get(list, key, default) do
    Enum.at(list, key, default)
  end

  def trim(list) do
    Enum.filter(list, &(!Potion.empty?(&1)))
  end

  def put(list, item) when is_list(item) do
    list ++ item
  end

  def put(list, item) do
    list ++ [item]
  end

  def put_first(list, item) when is_list(item) do
    item ++ list
  end

  def put_first(list, item) do
    [item] ++ list
  end
end

defimpl Potion.Collection, for: Map do
  def get(map, key, default) do
    Map.get(map, key, default)
  end

  def trim(map) do
    Enum.reduce(map, %{}, fn({key, value}, acc) ->
      case !Potion.empty?(key) && !Potion.empty?(value) do
      true -> Potion.put(acc, %{key => value})
      _ -> acc
      end
    end)
  end

  def put(map, item) when is_map(item) do
    Map.merge(map, item)
  end

  def put(map, [h] = _item) do
    Map.put(map, Potion.get(h, 0), Potion.get(h, 1))
  end

  def put(_list, _item) do
    raise RuntimeError, message: "invalid argument"
  end

  def put_first(map, item) when is_map(item) do
    Map.merge(item, map)
  end

  def put_first(map, [h] = _item) do
    Map.put_new(map, Potion.get(h, 0), Potion.get(h, 1))
  end

  def put_first(_list, _item) do
    raise RuntimeError, message: "invalid argument"
  end
end

defimpl Potion.Collection, for: Tuple do
  def get(tuple, key, default) do
    tuple |> Tuple.to_list() |> Enum.at(key, default)
  end

  def trim(tuple) do
    tuple |> Tuple.to_list() |> Enum.filter(&(!Potion.empty?(&1))) |> List.to_tuple
  end

  def put(tuple, item) do
    Tuple.append(tuple, item)
  end

  def put_first(tuple, item) do
    Tuple.insert_at(tuple, 0, item)
  end
end

defimpl Potion.Collection, for: Any do
  def get(_data, _key, _default) do
    raise RuntimeError, message: "invalid argument"
  end

  def trim(_list) do
    raise RuntimeError, message: "invalid argument"
  end

  def put(_data, _item) do
    raise RuntimeError, message: "invalid argument"
  end

  def put_first(_data, _item) do
    raise RuntimeError, message: "invalid argument"
  end
end