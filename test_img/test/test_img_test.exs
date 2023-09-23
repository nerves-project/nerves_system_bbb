defmodule TestImgTest do
  use ExUnit.Case
  doctest TestImg

  test "greets the world" do
    assert TestImg.hello() == :world
  end
end
