use Mix.Config

config :nerves_system_bbb, :nerves_env,
  type:  :system,
  build_platform: :nerves_system_br,
  bakeware: [target: "bbb", recipe: "nerves/bbb"],
  ext: [
    defconfig: "src/elixir_defconfig"
  ]
