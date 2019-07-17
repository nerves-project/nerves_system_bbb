defmodule TestTest do
  use ExUnit.Case

  test "i2c interface exists" do
    assert File.exists?("/dev/i2c-0")
    assert File.exists?("/dev/i2c-1")
  end
end
