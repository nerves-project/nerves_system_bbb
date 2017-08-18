defmodule TestTest do
  use ExUnit.Case
  doctest Test

  test "i2c interface exists" do
    assert File.exists?("/dev/i2c-0")
    assert File.exists?("/dev/i2c-2")
  end
end
