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

  describe "CAN devices" do
    @can_dev "ttyO3"

    test "/dev/#{@can_dev} exists" do
      assert File.exists? "/dev/#{@can_dev}"
    end

    test "/dev/ttyO3 is tty,type=250" do
      sysfs_file = "/sys/class/tty/#{@can_dev}/dev"
      assert File.exists? sysfs_file

      ret = sysfs_file |> File.read!() |> String.split(":", parts: 2)
      assert ["250", _] = ret
    end
  end
end
