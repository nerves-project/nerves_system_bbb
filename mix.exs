defmodule NervesSystemBbb.Mixfile do
  use Mix.Project

  @version Path.join(__DIR__, "VERSION")
    |> File.read!
    |> String.strip

  def project do
    [app: :nerves_system_bbb,
     version: @version,
     elixir: "~> 1.2",
     compilers: Mix.compilers ++ [:nerves_system],
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    []
  end

  defp deps do
    [{:nerves_system, "~> 0.1.5"},
     {:nerves_system_br, "~> 0.7.0"},
     {:nerves_toolchain_arm_unknown_linux_gnueabihf, "~> 0.7.0"}]
  end

  defp description do
    """
    Nerves System - BeagleBone Black
    """
  end

  defp package do
    [maintainers: ["Frank Hunleth", "Justin Schneck"],
     files: ["rootfs-additions", "bbb-busybox.config", "LICENSE",
             "mix.exs", "nerves_defconfig", "nerves.exs", "README.md",
             "VERSION", "fwup.conf", "post-createfs.sh", "uboot",
             "uboot-script.cmd", "linux"],
     licenses: ["Apache 2.0"],
     links: %{"Github" => "https://github.com/nerves-project/nerves_system_bbb"}]
  end
end
