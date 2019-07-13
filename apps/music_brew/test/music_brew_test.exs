defmodule MusicBrewTest do
  use ExUnit.Case
  doctest MusicBrew

  test "greets the world" do
    assert MusicBrew.hello() == :world
  end
end
