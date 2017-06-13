defmodule NervesSystemBbb.Mixfile do
  use Mix.Project

  @version Path.join(__DIR__, "VERSION")
    |> File.read!
    |> String.strip

  def project do
    [app: :nerves_system_bbb,
     version: @version,
     elixir: "~> 1.3",
     compilers: Mix.compilers ++ [:nerves_package],
     description: description(),
     package: package(),
     deps: deps(),
     aliases: ["deps.precompile": ["nerves.env", "deps.precompile"]]]
  end

  def application do
    []
  end

  defp deps do
    [{:nerves, "~> 0.5", runtime: false },
     {:nerves_system_br, "~> 0.12.0", runtime: false },
     {:nerves_toolchain_arm_unknown_linux_gnueabihf, "~> 0.10.0", runtime: false}]
  end

  defp description do
    """
    Nerves System - BeagleBone Black, BeagleBone Green
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
