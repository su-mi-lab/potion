defmodule PotionTest do
  use ExUnit.Case

  doctest Potion

  defstruct name: "potion", age: 14

  test "test Potion empty" do
    assert Potion.empty?([]) == true
    assert Potion.empty?(%{}) == true
    assert Potion.empty?({}) == true
    assert Potion.empty?("") == true
    assert Potion.empty?(false) == true
    assert Potion.empty?(:false) == true
    assert Potion.empty?(nil) == true

    assert Potion.empty?([1, 2]) == false
    assert Potion.empty?(%{map: "some content"}) == false
    assert Potion.empty?({1, 2}) == false
    assert Potion.empty?("some content") == false
    assert Potion.empty?(1) == false
    assert Potion.empty?(1.0) == false
    assert Potion.empty?(true) == false
    assert Potion.empty?(:true) == false
    assert Potion.empty?(%PotionTest{}) == false
    assert Potion.empty?(self()) == false

  end

  test "test Potion get" do
    assert Potion.get([1, 2, 3], 0) == 1
    assert Potion.get({1, 2, 3}, 0) == 1
    assert Potion.get([1, "2", 3], 1) == "2"
    assert Potion.get([index: 1, index2: 2], :index2) == 2
    assert Potion.get({:ok, "some content"}, :ok) == "some content"
    assert Potion.get(%{map: "some content"}, :map) == "some content"
    assert Potion.get(%PotionTest{}, :name) == "potion"

    assert Potion.get([1, 2, 3], 4) == nil
    assert Potion.get({1, 2, 3}, 4) == nil
    assert Potion.get(%{map: "some content"}, :test) == nil
  end

  test "test Potion trim" do
    assert Potion.trim([1, 2, 3]) == [1, 2, 3]
    assert Potion.trim(%{map: "some content"}) == %{map: "some content"}
    assert Potion.trim({1, 2}) == {1, 2}
    assert Potion.trim([1, "", 3]) == [1, 3]
    assert Potion.trim({1, ""}) == {1}
    assert Potion.trim(%{map: ""}) == %{}
    assert Potion.trim(%{map: "some content", map2: ""}) == %{map: "some content"}
  end

  test "test Potion put" do
    assert Potion.put([1], 2) == [1, 2]
    assert Potion.put([1], [2]) == [1, 2]
    assert Potion.put([1], "2") == [1, "2"]
    assert Potion.put([1], :add) == [1, :add]
    assert Potion.put(%{map: "some content"}, add: "some content") == %{map: "some content", add: "some content"}
    assert Potion.put(%{map: "some content"}, add: %{map: "some content"}) == %{map: "some content", add: %{map: "some content"}}
    assert Potion.put(%{map: "some content"}, [add: "some content"]) == %{map: "some content", add: "some content"}
    assert Potion.put(%{map: "some content"}, %{"add" => "some content"}) == %{:map => "some content", "add" => "some content"}
    assert Potion.put(%{map: "some content"}, %{add: "some content"}) == %{map: "some content", add: "some content"}
    assert Potion.put(%{map: "some content"}, %{map: "some content!"}) == %{map: "some content!"}
    assert Potion.put({1, 2, 3}, 4) == {1, 2, 3, 4}
    assert Potion.put({1, 2, 3}, :add) == {1, 2, 3,:add}
    assert Potion.put({1, 2, 3}, [1, 2]) == {1, 2, 3, [1, 2]}
    assert Potion.put(%PotionTest{}, %{name: "some content"}) == %PotionTest{name: "some content", age: 14}
    assert Potion.put(%PotionTest{}, name: "some content") == %PotionTest{name: "some content", age: 14}
    assert Potion.put(%PotionTest{}, [name: "some content"]) == %PotionTest{name: "some content", age: 14}

  end

  test "test Potion put_first" do
    assert Potion.put_first([1], 2) == [2, 1]
    assert Potion.put_first([1], [2]) == [2, 1]
    assert Potion.put_first([1], "2") == ["2", 1]
    assert Potion.put_first([1], :add) == [:add, 1]
    assert Potion.put_first(%{map: "some content"}, add: "some content") == %{add: "some content", map: "some content"}
    assert Potion.put_first(%{map: "some content"}, add: %{map: "some content"}) == %{add: %{map: "some content"}, map: "some content"}
    assert Potion.put_first(%{map: "some content"}, [add: "some content"]) == %{add: "some content", map: "some content"}
    assert Potion.put_first(%{map: "some content"}, %{"add" => "some content"}) == %{"add" => "some content", :map => "some content"}
    assert Potion.put_first(%{map: "some content"}, %{add: "some content"}) == %{add: "some content", map: "some content"}
    assert Potion.put_first(%{map: "some content"}, %{map: "some content!"}) == %{map: "some content"}
    assert Potion.put_first({1, 2, 3}, 4) == {4, 1, 2, 3}
    assert Potion.put_first({1, 2, 3}, :add) == {:add, 1, 2, 3}
    assert Potion.put_first({1, 2, 3}, [1, 2]) == {[1, 2], 1, 2, 3}
    assert Potion.put_first(%PotionTest{}, %{name: "some content"}) == %PotionTest{name: "potion", age: 14}
    assert Potion.put_first(%PotionTest{}, name: "some content") == %PotionTest{name: "potion", age: 14}
    assert Potion.put_first(%PotionTest{}, [name: "some content"]) == %PotionTest{name: "potion", age: 14}
  end

  test "test Potion unset" do
    assert Potion.unset([1, 2], 0) == [2]
    assert Potion.unset([1, 2], [0, 1]) == []
    assert Potion.unset([1, 2], [1, 2]) == [1]
    assert Potion.unset([1, 2,3], [0, 2, 1]) == []
    assert Potion.unset([1, "2"], 1) == [1]
    assert Potion.unset([1, 2], 3) == [1, 2]
    assert Potion.unset(%{a: 1, b: 2}, :a) == %{b: 2}
    assert Potion.unset(%{b: 2}, :a) == %{b: 2}
    assert Potion.unset(%{a: 1, b: 2}, [:a, :b]) == %{}
    assert Potion.unset(%{a: 1, b: 2}, [:b, :c]) == %{a: 1}
    assert Potion.unset({1, 2}, 0) == {2}
    assert Potion.unset({1, 2}, [0, 1]) == {}
    assert Potion.unset({1, 2}, [1, 2]) == {1}
    assert Potion.unset({1, 2}, 2) == {1, 2}
    assert Potion.unset({1, 2, :number}, 2) == {1, 2}
  end

  test "test Potion unset_value" do
    assert Potion.unset_value([1, 2], 2) == [1]
    assert Potion.unset_value([1, 2], [0,1]) == [2]
    assert Potion.unset_value([1, 2], [1,2]) == []
    assert Potion.unset_value([1, "2"], "2") == [1]
    assert Potion.unset_value([1, 2], 3) == [1,2]
    assert Potion.unset_value({1, 2}, 0) == {1,2}
    assert Potion.unset_value({1, 2}, [0,1]) == {2}
    assert Potion.unset_value({1, 2}, [1,2]) == {}
    assert Potion.unset_value({1, 2}, 2) == {1}
    assert Potion.unset_value({1, 2, :number}, 2) == {1,:number}
    assert Potion.unset_value(%{a: 1, b: 2}, 1) == %{b: 2}
    assert Potion.unset_value(%{a: "some content", b: "some content", c: 3}, "some content") == %{c: 3}
    assert Potion.unset_value(%{a: 1, b: 2}, [1, 2]) == %{}
    assert Potion.unset_value(%{a: 1, b: 2}, [1,3]) == %{b: 2}
    assert Potion.unset_value(%{a: "some content", b: "some content", c: 3}, ["some content", 3]) == %{}
  end

  test "test Potion to_atom" do
    assert Potion.to_atom("atom") == :atom
    assert Potion.to_atom('atom') == :atom
    assert Potion.to_atom(:atom) == :atom
  end

  test "test Potion to_string" do
    assert Potion.to_string("string") == "string"
    assert Potion.to_string('string') == "string"
    assert Potion.to_string(:string) == "string"
    assert Potion.to_string(1) == "1"
    assert Potion.to_string(1.0) == "1.0"
  end

  test "test Potion to_float" do
    assert Potion.to_float("1.0") == 1.0
    assert Potion.to_float("1") == 1.0
    assert Potion.to_float('1.0') == 1.0
    assert Potion.to_float(1) == 1.0
    assert Potion.to_float(1.0) == 1.0
  end

  test "test Potion to_integer" do
    assert Potion.to_integer("1") == 1
    assert Potion.to_integer("1.0") == 1
    assert Potion.to_integer('1') == 1
    assert Potion.to_integer(1) == 1
    assert Potion.to_integer(1.0) == 1
    assert Potion.to_integer(1.5) == 1
  end

  test "test Potion change_key_atom" do
    assert Potion.change_key_atom(%{:key => 1, "key2" => 2}) == %{key: 1, key2: 2}
    assert Potion.change_key_atom(%{"key" => 1, "key2" => 2}) == %{key: 1, key2: 2}
  end

end
