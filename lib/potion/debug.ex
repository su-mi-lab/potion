defprotocol Potion.Debug do
  @fallback_to_any true

  @spec debug(any, Integer.t) :: String.t
  def debug(data, nest)
end

defimpl Potion.Debug, for: BitString do
  def debug(str, _nest), do: {:BitString, str}
end

defimpl Potion.Debug, for: Atom do
  def debug(atom, _nest), do: {:Atom, ":"<>Potion.to_string(atom)}
end

defimpl Potion.Debug, for: Integer do
  def debug(int, _nest), do: {:Integer, Potion.to_string(int)}
end

defimpl Potion.Debug, for: Float do
  def debug(float, _nest), do: {:Float, Potion.to_string(float)}
end

defimpl Potion.Debug, for: List do
  def debug(list, nest) do
    message = list
    |> Stream.with_index
    |> Enum.map(fn({val, index}) ->
      {_, index} = Potion.Debug.debug(index, nest + 1)
      {type, val} = Potion.Debug.debug(val, nest + 1)

      space = String.duplicate("  ", nest + 1)

      "#{space} [" <> index <> "]" <> " => " <> "#{type}: "<>val
    end)
    |> Enum.join("\n")

    if nest >= 1 do
      {:List, "\n" <> message}
    else
      {:List, message}
    end
  end
end

defimpl Potion.Debug, for: Map do
  def debug(map, nest) do

    message = map
    |> Enum.map(fn({index, val}) ->
      {_, index} = Potion.Debug.debug(index, nest + 1)
      {type, val} = Potion.Debug.debug(val, nest + 1)

      space = String.duplicate("  ", nest + 1)

      "#{space} %{" <> index <> "} => " <> "#{type}: "<>val
    end)
    |> Enum.join("\n")

    if nest >= 1 do
      {:Map, "\n" <> message}
    else
      {:Map, message}
    end
  end

end

defimpl Potion.Debug, for: Tuple do
  def debug(tuple, nest) do
    message = tuple
    |> Tuple.to_list()
    |> Stream.with_index
    |> Enum.map(fn({val, index}) ->
      {_, index} = Potion.Debug.debug(index, nest + 1)
      {type, val} = Potion.Debug.debug(val, nest + 1)

      space = String.duplicate("  ", nest + 1)

      "#{space} {" <> index <> "} => " <> "#{type}: "<>val
    end)
    |> Enum.join("\n")

    if nest >= 1 do
      {:Tuple, "\n" <> message}
    else
      {:Tuple, message}
    end
  end

end

defimpl Potion.Debug, for: Any do

  def debug(map, nest) when is_map(map) do
    {_, message} = Potion.Debug.debug(Map.from_struct(map), nest)
    if nest > 1 do
      {:Struct, "\n" <> message}
    else
      {:Struct, message}
    end
  end

  def debug(_data, _nest) do
    raise RuntimeError, message: "invalid argument"
  end
end