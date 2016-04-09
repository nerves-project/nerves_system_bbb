use Mix.Config

config :nerves_system_bbb, :nerves_env,
  type: :system,
  bakeware: [target: "bbb", recipe: "nerves/bbb"],
  build_platform: Nerves.System.Platforms.BR,
  build_config: [
    defconfig: "nerves_defconfig"
  ]
