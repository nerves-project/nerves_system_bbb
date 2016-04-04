use Mix.Config

config :nerves_system_bbb, :nerves_env,
  type: :system,
  build_platform: Nerves.System.Platforms.BR,
  bakeware: [target: "bbb", recipe: "nerves/bbb"],
  ext: [
    defconfig: "nerves_defconfig"
  ]
