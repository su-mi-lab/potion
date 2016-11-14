defprotocol Potion.Convert do
  @fallback_to_any true

  @spec to_atom(BitString.t | List.t | Atom.t) :: Atom.t
  def to_atom(item)

  @spec to_string(BitString.t | List.t | Atom.t | Float.t | Integer.t) :: BitString.t
  def to_string(item)

  @spec to_float(BitString.t | List.t |  Float.t | Integer.t) :: Float.t
  def to_float(item)

  @spec to_integer(BitString.t | List.t |  Float.t | Integer.t) :: Integer.t
  def to_integer(item)
end

defimpl Potion.Convert, for: Integer do
  def to_atom(_item) do
    raise RuntimeError, message: "invalid argument"
  end

  def to_string(item), do: Integer.to_string(item)
  def to_float(item), do: item/1
  def to_integer(item), do: item
end

defimpl Potion.Convert, for: Float do
  def to_atom(_item) do
    raise RuntimeError, message: "invalid argument"
  end

  def to_string(item), do: Float.to_string(item)
  def to_float(item), do: item
  def to_integer(item), do: trunc(item)
end

defimpl Potion.Convert, for: List do
  def to_atom(item), do: List.to_atom(item)
  def to_string(item), do: List.to_string(item)
  def to_float(item), do: List.to_float(item)
  def to_integer(item), do: List.to_integer(item)
end

defimpl Potion.Convert, for: BitString do
  def to_atom(item), do: String.to_atom(item)
  def to_string(item), do: item
  def to_float(item), do: Float.parse(item) |> Tuple.to_list |> Enum.at(0)
  def to_integer(item), do: Integer.parse(item) |> Tuple.to_list |> Enum.at(0)
end

defimpl Potion.Convert, for: Atom do
  def to_atom(item), do: item
  def to_string(item), do: Atom.to_string(item)

  def to_float(_item) do
    raise RuntimeError, message: "invalid argument"
  end

  def to_integer(_item) do
    raise RuntimeError, message: "invalid argument"
  end

end

defimpl Potion.Convert, for: Any do
  def to_atom(_item) do
    raise RuntimeError, message: "invalid argument"
  end

  def to_string(_item) do
    raise RuntimeError, message: "invalid argument"
  end

  def to_float(_item) do
    raise RuntimeError, message: "invalid argument"
  end

  def to_integer(_item) do
    raise RuntimeError, message: "invalid argument"
  end
end
