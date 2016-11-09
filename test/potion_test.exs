defmodule PotionTest do
  use ExUnit.Case
  doctest Potion

  test "test Potion empty" do
    assert Potion.empty?([]) == true
    assert Potion.empty?(%{}) == true
    assert Potion.empty?({}) == true
    assert Potion.empty?("") == true

    assert Potion.empty?([1,2]) == false
    assert Potion.empty?(%{map: "some content"}) == false
    assert Potion.empty?({1, 2}) == false
    assert Potion.empty?("some content") == false
    assert Potion.empty?(1) == false
    assert Potion.empty?(1.0) == false
    assert Potion.empty?(:test) == false
  end

  test "test Potion get" do
    assert Potion.get([1,2,3], 0) == 1
    assert Potion.get({1,2,3}, 0) == 1
    assert Potion.get(%{map: "some content"}, :map) == "some content"


    assert Potion.get([1,2,3], 4) == nil
    assert Potion.get({1,2,3}, 4) == nil
    assert Potion.get(%{map: "some content"}, :test) == nil
  end

end
