defmodule Potion do

  def empty?(data) do
    Potion.Empty.empty?(data)
  end

  def get(data, key, default \\ nil) do
    Potion.Collection.get(data, key, default)
  end

end
