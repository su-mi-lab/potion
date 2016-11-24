defmodule Potion do

  @doc """

  check empty

  ## Examples

      Potion.empty?([])
      true
      Potion.empty?(%{})
      true
      Potion.empty?({})
      true
      Potion.empty?("")
      true
      Potion.empty?(nil)
      true
      Potion.empty?(false)
      true

      Potion.empty?([1,2])
      false
      Potion.empty?(%{map: "some content"})
      false
      Potion.empty?({1, 2})
      false
      Potion.empty?("some content")
      false
      Potion.empty?(1)
      false
      Potion.empty?(true)
      false
  """
  @spec empty?(any) :: boolean
  def empty?(data) do
    Potion.Empty.empty?(data)
  end

  @doc """

  Gets the value for a specific key

  ## Examples

      Potion.get([1,2,3], 0)
      1
      Potion.get([1,2,3], 4)
      nil
      Potion.get({1,2,3}, 0)
      1
      Potion.get([index: 1, index2: 2], :index2)
      2
      Potion.get({:ok, "some content"}, :ok)
      "some content"
      Potion.get(%{map: "some content"}, :map)
      "some content"
      Potion.get([1,2,3], 4, 0)
      0
  """
  @spec get(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t, any) :: any
  def get(data, key, default \\ nil) do
    Potion.Collection.get(data, key, default)
  end

  @doc """

  Collection trim

  ## Examples

      Potion.trim([1,"",3])
      [1,3]
      Potion.trim(%{map: "some content", map2: ""})
      %{map: "some content"}
      Potion.trim({1, ""})
      {1}

  """
  @spec trim(Map.t | List.t | Tuple.t) :: Map.t | List.t | Tuple.t
  def trim(data) do
    Potion.Collection.trim(data)
  end

  @doc """

  Puts the given value

  ## Examples

      Potion.put([1], 2)
      [1,2]
      Potion.put([1], [2])
      [1,2]
      Potion.put(%{map: "some content"}, add: "some content")
      %{map: "some content", add: "some content"}
      Potion.put(%{map: "some content"}, [add: "some content"])
      %{map: "some content", add: "some content"}
      Potion.put(%{map: "some content"}, %{add: "some content"})
      %{map: "some content", add: "some content"}
      Potion.put(%{map: "some content"}, %{map: "some content!"})
      %{map: "some content!"}
      Potion.put({1,2,3}, 4)
      {1,2,3,4}

  """
  @spec put(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put(data, item) do
    Potion.Collection.put(data, item)
  end

  @doc """

  Puts the given value

  ## Examples

      Potion.put_first([1], 2)
      [2,1]
      Potion.put_first([1], [2])
      [2,1]
      Potion.put_first(%{map: "some content"}, add: "some content")
      %{add: "some content", map: "some content"}
      Potion.put_first(%{map: "some content"}, [add: "some content"])
      %{add: "some content", map: "some content"}
      Potion.put_first(%{map: "some content"}, %{add: "some content"})
      %{add: "some content", map: "some content"}
      Potion.put_first(%{map: "some content"}, %{map: "some content!"})
      %{map: "some content"}
      Potion.put_first({1,2,3}, 4)
      {4,1,2,3}

  """
  @spec put_first(Map.t | List.t | Tuple.t, any) :: Map.t | List.t | Tuple.t
  def put_first(data, item) do
    Potion.Collection.put_first(data, item)
  end

  @doc """

  Deletes the given value from  key

  ## Examples

      Potion.unset([1,2], 0)
      [2]
      Potion.unset(%{a: 1, b: 2}, :a)
      %{b: 2}
      Potion.unset({1,2}, 0)
      {2}
      Potion.unset([1,2], [0,1])
      []
      Potion.unset(%{a: 1, b: 2}, [:a, :b])
      %{}
      Potion.unset({1,2}, [1,2])
      {1}

  """
  @spec unset(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t | List.t) :: any
  def unset(data, key) do
    Potion.Collection.unset(data, key)
  end

  @doc """

  Deletes the given value from  value

  ## Examples

      Potion.unset_value([1,2], 2)
      [1]
      Potion.unset_value([1,2], [0,1])
      [2]
      Potion.unset_value(%{a: 1, b: 2}, 1)
      %{b: 2}
      Potion.unset_value(%{a: 1, b: 2}, [1, 2])
      %{}
      Potion.unset_value({1,2}, 2)
      {1}
      Potion.unset_value({1,2}, [1,2])
      {}

  """
  @spec unset_value(Map.t | List.t | Tuple.t, String.t | Integer.t | Atom.t | List.t) :: any
  def unset_value(data, value) do
    Potion.Collection.unset_value(data, value)
  end

  @doc """

  Converts atom

  ## Examples

      Potion.to_atom("atom")
      :atom
      Potion.to_atom('atom')
      :atom
      Potion.to_atom(:atom)
      :atom

  """
  @spec to_atom(BitString.t | List.t | Atom.t) :: Atom.t
  def to_atom(item) do
    Potion.Convert.to_atom(item)
  end

  @doc """

  Converts string

  ## Examples

      Potion.to_string("string")
      "string"
      Potion.to_string('string')
      "string"
      Potion.to_string(:string)
      "string"
      Potion.to_string(1)
      "1"
      Potion.to_string(1.0)
      "1.0"

  """
  @spec to_string(BitString.t | List.t | Atom.t | Float.t | Integer.t) :: BitString.t
  def to_string(item) do
    Potion.Convert.to_string(item)
  end

    @doc """

    Converts float

    ## Examples

        Potion.to_float("1.0")
        1.0
        Potion.to_float('1.0')
        1.0
        Potion.to_float(1)
        1.0
        Potion.to_float(1.0)
        1.0

    """
    @spec to_float(BitString.t | List.t |  Float.t | Integer.t) :: Float.t
    def to_float(item) do
      Potion.Convert.to_float(item)
    end

    @doc """

    Converts integer

    ## Examples

        Potion.to_integer("1")
        1
        Potion.to_integer('1')
        1
        Potion.to_integer(1)
        1
        Potion.to_integer(1.0)
        1
        Potion.to_integer(1.5)
        1

    """
    @spec to_integer(BitString.t | List.t |  Float.t | Integer.t) :: Integer.t
    def to_integer(item) do
      Potion.Convert.to_integer(item)
    end
end
