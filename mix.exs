defmodule NervesSystemBbb.Mixfile do
  use Mix.Project

  def project do
    [app: :nerves_system_bbb,
     version: "0.4.0-rc2",
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
    [{:nerves_system, github: "nerves-project/nerves_system"},
     {:nerves_system_br, github: "nerves-project/nerves-system-br"},
     {:nerves_toolchain_arm_unknown_linux_gnueabihf, github: "nerves-project/nerves_toolchain_arm_unknown_linux_gnueabihf"}]
  end

  defp description do
    """
    Nerves System - BeagleBone Black
    """
  end

  defp package do
    [maintainers: ["Frank Hunleth", "Justin Schneck"],
     licenses: ["Apache 2.0"],
     links: %{"Github" => "https://github.com/nerves-project/nerves_system_bbb"}]
  end
end
