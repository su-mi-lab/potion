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

      iex> Potion.get([1,2,3], 0)
      1
      iex> Potion.get([1,2,3], 4)
      nil
      iex> Potion.get({1,2,3}, 0)
      1
      iex> Potion.get({:ok, "some content"}, :ok)
      "some content"
      iex> Potion.get(%{map: "some content"}, :map)
      "some content"
      iex> Potion.get([1,2,3], 4, 0)
      0
  """
  @spec get(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t, any) :: any
  def get(data, key, default \\ nil) do
    Potion.Collection.get(data, key, default)
  end

  @doc """
  ## Examples

      iex> assert Potion.trim([1,"",3])
      [1,3]
      iex> Potion.trim(%{map: "some content", map2: ""})
      %{map: "some content"}
      iex> Potion.trim({1, ""})
      {1}

  """
  @spec trim(Map.t | List.t | Tuple.t) :: Map.t | List.t | Tuple.t
  def trim(data) do
    Potion.Collection.trim(data)
  end

  @doc """
  ## Examples

      iex> Potion.put([1], 2)
      [1,2]
      iex> Potion.put([1], [2])
      [1,2]
      iex> Potion.put(%{map: "some content"}, add: "some content")
      %{map: "some content", add: "some content"}
      iex> Potion.put(%{map: "some content"}, [add: "some content"])
      %{map: "some content", add: "some content"}
      iex> Potion.put(%{map: "some content"}, %{add: "some content"})
      %{map: "some content", add: "some content"}
      iex> Potion.put(%{map: "some content"}, %{map: "some content!"})
      %{map: "some content!"}
      iex> Potion.put({1,2,3}, 4)
      {1,2,3,4}

  """
  @spec put(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put(data, item) do
    Potion.Collection.put(data, item)
  end

  @doc """
  ## Examples

      iex> Potion.put_first([1], 2)
      [2,1]
      iex> Potion.put_first([1], [2])
      [2,1]
      iex> Potion.put_first(%{map: "some content"}, add: "some content")
      %{add: "some content", map: "some content"}
      iex> Potion.put_first(%{map: "some content"}, [add: "some content"])
      %{add: "some content", map: "some content"}
      iex> Potion.put_first(%{map: "some content"}, %{add: "some content"})
      %{add: "some content", map: "some content"}
      iex> Potion.put_first(%{map: "some content"}, %{map: "some content!"})
      %{map: "some content"}
      iex> Potion.put_first({1,2,3}, 4)
      {4,1,2,3}

  """
  @spec put_first(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put_first(data, item) do
    Potion.Collection.put_first(data, item)
  end

  @doc """
  ## Examples

      iex> Potion.unset([1,2], 0)
      [2]
      iex> Potion.unset(%{a: 1, b: 2}, :a)
      %{b: 2}
      iex> Potion.unset({1,2}, 0)
      {2}
      iex> Potion.unset([1,2], [0,1])
      []
      iex> Potion.unset(%{a: 1, b: 2}, [:a, :b])
      %{}
      iex> Potion.unset({1,2}, [1,2])
      {1}

  """
  @spec unset(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t | List.t) :: any
  def unset(data, key) do
    Potion.Collection.unset(data, key)
  end

  @doc """
  ## Examples

      iex> Potion.unset_value([1,2], 2)
      [1]
      iex> Potion.unset_value([1,2], [0,1])
      [2]
      iex> Potion.unset_value(%{a: 1, b: 2}, 1)
      %{b: 2}
      iex> Potion.unset_value(%{a: 1, b: 2}, [1, 2])
      %{}
      iex> Potion.unset_value({1,2}, 2)
      {1}
      iex> Potion.unset_value({1,2}, [1,2])
      {}

  """
  @spec unset_value(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t | List.t) :: any
  def unset_value(data, value) do
    Potion.Collection.unset_value(data, value)
  end

end
