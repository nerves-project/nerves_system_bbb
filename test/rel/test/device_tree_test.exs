defmodule DeviceTreeTest do
  use ExUnit.Case

  describe "chosen overlays" do
    test "BB-BBBW-WL1835-00A0" do
      assert File.exists?("/proc/device-tree/chosen/overlays/BB-BBBW-WL1835-00A0")
    end

    test "BB-BONE-eMMC1-01-00A0" do
      assert File.exists?("/proc/device-tree/chosen/overlays/BB-BONE-eMMC1-01-00A0")
    end

    test "BB-ZOLA-GATEWAY--00A0" do
      assert File.exists?("/proc/device-tree/chosen/overlays/BB-ZOLA-GATEWAY-00A0")
    end
  end
end
