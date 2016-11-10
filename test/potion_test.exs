defmodule PotionTest do
  use ExUnit.Case
  doctest Potion

  test "test Potion empty" do
    assert Potion.empty?([]) == true
    assert Potion.empty?(%{}) == true
    assert Potion.empty?({}) == true
    assert Potion.empty?("") == true
    assert Potion.empty?(false) == true
    assert Potion.empty?(:false) == true
    assert Potion.empty?(nil) == true

    assert Potion.empty?([1,2]) == false
    assert Potion.empty?(%{map: "some content"}) == false
    assert Potion.empty?({1, 2}) == false
    assert Potion.empty?("some content") == false
    assert Potion.empty?(1) == false
    assert Potion.empty?(1.0) == false
    assert Potion.empty?(true) == false
    assert Potion.empty?(:true) == false
  end

  test "test Potion get" do
    assert Potion.get([1,2,3], 0) == 1
    assert Potion.get({1,2,3}, 0) == 1
    assert Potion.get(%{map: "some content"}, :map) == "some content"

    assert Potion.get([1,2,3], 4) == nil
    assert Potion.get({1,2,3}, 4) == nil
    assert Potion.get(%{map: "some content"}, :test) == nil
  end

  test "test Potion trim" do
    assert Potion.trim([1,2,3]) == [1,2,3]
    assert Potion.trim(%{map: "some content"}) == %{map: "some content"}
    assert Potion.trim({1, 2}) == {1, 2}
    assert Potion.trim([1,"",3]) == [1,3]
    assert Potion.trim({1, ""}) == {1}
    assert Potion.trim(%{map: ""}) == %{}
    assert Potion.trim(%{map: "some content", map2: ""}) == %{map: "some content"}
  end

  test "test Potion put" do
    assert Potion.put([1], 2) == [1,2]
    assert Potion.put([1], [2]) == [1,2]
    assert Potion.put([1], "2") == [1,"2"]
    assert Potion.put([1], :add) == [1,:add]
    assert Potion.put(%{map: "some content"}, add: "some content") == %{map: "some content", add: "some content"}
    assert Potion.put(%{map: "some content"}, add: %{map: "some content"}) == %{map: "some content", add: %{map: "some content"}}
    assert Potion.put(%{map: "some content"}, [add: "some content"]) == %{map: "some content", add: "some content"}
    assert Potion.put(%{map: "some content"}, %{"add" => "some content"}) == %{:map => "some content", "add" => "some content"}
    assert Potion.put(%{map: "some content"}, %{add: "some content"}) == %{map: "some content", add: "some content"}
    assert Potion.put(%{map: "some content"}, %{map: "some content!"}) == %{map: "some content!"}
    assert Potion.put({1,2,3}, 4) == {1,2,3,4}
    assert Potion.put({1,2,3}, :add) == {1,2,3,:add}
    assert Potion.put({1,2,3}, [1,2]) == {1,2,3,[1,2]}
  end

  test "test Potion put_first" do
    assert Potion.put_first([1], 2) == [2,1]
    assert Potion.put_first([1], [2]) == [2,1]
    assert Potion.put_first([1], "2") == ["2",1]
    assert Potion.put_first([1], :add) == [:add,1]
    assert Potion.put_first(%{map: "some content"}, add: "some content") == %{add: "some content", map: "some content"}
    assert Potion.put_first(%{map: "some content"}, add: %{map: "some content"}) == %{add: %{map: "some content"}, map: "some content"}
    assert Potion.put_first(%{map: "some content"}, [add: "some content"]) == %{add: "some content", map: "some content"}
    assert Potion.put_first(%{map: "some content"}, %{"add" => "some content"}) == %{"add" => "some content", :map => "some content"}
    assert Potion.put_first(%{map: "some content"}, %{add: "some content"}) == %{add: "some content", map: "some content"}
    assert Potion.put_first(%{map: "some content"}, %{map: "some content!"}) == %{map: "some content"}
    assert Potion.put_first({1,2,3}, 4) == {4,1,2,3}
    assert Potion.put_first({1,2,3}, :add) == {:add,1,2,3}
    assert Potion.put_first({1,2,3}, [1,2]) == {[1,2],1,2,3}
  end

end
