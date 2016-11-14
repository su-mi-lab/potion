defprotocol Potion.Empty do
  @fallback_to_any true

  @spec empty?(any) :: boolean
  def empty?(data)
end

defimpl Potion.Empty, for: [Integer, Float, Function, PID, Port] do
  def empty?(_), do: false
end

defimpl Potion.Empty, for: List do
  def empty?([]), do: true
  def empty?(_),  do: false
end

defimpl Potion.Empty, for: Map do
  def empty?(map), do: map_size(map) == 0
end

defimpl Potion.Empty, for: BitString do
  def empty?(""), do: true
  def empty?(_),  do: false
end

defimpl Potion.Empty, for: Atom do
  def empty?(:false), do: true
  def empty?(nil),   do: true
  def empty?(_),     do: false
end

defimpl Potion.Empty, for: Tuple do
  def empty?(tuple), do: tuple_size(tuple) == 0
end

defimpl Potion.Empty, for: Any do
  def empty?(_), do: false
end
