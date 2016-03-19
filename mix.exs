defmodule NervesSystemBbb.Mixfile do
  use Mix.Project

  def project do
    [app: :nerves_system_bbb,
     version: "0.4.0-rc2",
     elixir: "~> 1.2",
     compilers: Mix.compilers ++ [:nerves_system],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [env: [
    ]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:nerves_system, path: "../nerves_system"},
      {:nerves_system_br, path: "../nerves-system-br"},
      {:nerves_toolchain_arm_unknown_linux_gnueabihf, path: "../nerves_toolchain_arm_unknown_linux_gnueabihf"}
    ]
  end
end
