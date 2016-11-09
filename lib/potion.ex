defmodule Potion do


  @doc """

  Determines if the value is empty.

  ## Examples

      iex> Potion.empty?([])
      true
      iex> Potion.empty?(%{})
      true
      iex> Potion.empty?({})
      true
      iex> Potion.empty?("")
      true
      iex> Potion.empty?(nil)
      true
      iex> Potion.empty?(false)
      true

      iex> Potion.empty?([1,2])
      false
      iex> Potion.empty?(%{map: "some content"})
      false
      iex> Potion.empty?({1, 2})
      false
      iex> Potion.empty?("some content")
      false
      iex> Potion.empty?(1)
      false
      iex> Potion.empty?(true)
      false
  """
  @spec empty?(any) :: boolean
  def empty?(data) do
    Potion.Empty.empty?(data)
  end

  @doc """
  ## Examples

      iex> Potion.empty?(Potion.get([1,2,3], 0))
      1
      iex> Potion.empty?(Potion.get([1,2,3], 4))
      nil
      iex> Potion.empty?(Potion.get({1,2,3}, 0))
      1
      iex> Potion.get(%{map: "some content"}, :map)
      "some content"
      iex> Potion.empty?(Potion.get([1,2,3], 4, 0))
      0

  """
  @spec get(any, String.t | Integer.t | Atom.t, any) :: any
  def get(data, key, default \\ nil) do
    Potion.Collection.get(data, key, default)
  end

end
