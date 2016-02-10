defmodule NervesSystemBbb.Mixfile do
  use Mix.Project

  def project do
    [app: :nerves_system_bbb,
     version: "0.0.1",
     elixir: "~> 1.2",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [env: [target: "bbb"]]
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
      {:nerves_system_br, path: "../nerves_system_br"},
      {:nerves_toolchain_arm_unknown_linux_gnueabihf, path: "../nerves_toolchain_arm_unknown_linux_gnueabihf"}
    ]
  end
end
