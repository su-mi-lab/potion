defprotocol Potion.Collection do
  @spec get(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t, any) :: any
  def get(data, key, default)

  @spec trim(Map.t | List.t | Tuple.t) :: Map.t | List.t | Tuple.t
  def trim(data)

  @spec put(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put(data, item)

  @spec put_first(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put_first(data, item)

  @spec unset(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t | List.t) :: any
  def unset(data, key)

  @spec unset_value(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t | List.t) :: any
  def unset_value(data, value)
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

  def unset(list, keys) when is_list(keys) do
    Enum.reduce(Enum.reverse(keys), list, fn(key, acc) ->
      List.delete_at(acc, key)
    end)
  end

  def unset(list, key) do
    List.delete_at(list, key)
  end

  def unset_value(list, values) when is_list(values) do
    Enum.reduce(values, list, fn(value, acc) ->
      List.delete(acc, value)
    end)
  end

  def unset_value(list, value) do
    List.delete(list, value)
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

  def unset(map, keys) when is_list(keys) do
    Map.drop(map, keys)
  end

  def unset(map, key) do
    Map.delete(map, key)
  end

  def unset_value(map, values) when is_list(values) do
    Enum.reduce(map, %{}, fn({key, val}, acc) ->
      case Enum.member?(values, val) do
        false -> Potion.Collection.put(acc, %{key => val})
        _ -> acc
      end
    end)
  end

  def unset_value(map, value) do
    Enum.reduce(map, %{}, fn({key, val}, acc) ->
      case value != val do
        true -> Potion.Collection.put(acc, %{key => val})
        _ -> acc
      end
    end)
  end
end

defimpl Potion.Collection, for: Tuple do

  def get(tuple, key, default) when is_atom(key) do
    case tuple do
      {^key, data} -> data
      _ -> default
    end
  end

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

  def unset(tuple, keys) when is_list(keys) do
    Tuple.to_list(tuple) |> Potion.Collection.unset(keys) |> List.to_tuple
  end

  def unset(tuple, key) do
    Tuple.to_list(tuple) |> Potion.Collection.unset(key) |> List.to_tuple
  end

  def unset_value(tuple, values) when is_list(values) do
    Tuple.to_list(tuple) |> Potion.Collection.unset_value(values) |> List.to_tuple
  end

  def unset_value(tuple, value) do
    Tuple.to_list(tuple) |> Potion.Collection.unset_value(value) |> List.to_tuple
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

  def unset(_data, _key) do
    raise RuntimeError, message: "invalid argument"
  end

  def unset_value(_data, _value) do
    raise RuntimeError, message: "invalid argument"
  end
end