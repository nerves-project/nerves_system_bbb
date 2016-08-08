use Mix.Config

version =
  Path.join(__DIR__, "VERSION")
  |> File.read!
  |> String.strip

config :nerves_system_bbb, :nerves_env,
  type: :system,
  version: version,
  mirrors: [
    "https://github.com/nerves-project/nerves_system_bbb/releases/download/v#{version}/nerves_system_bbb-v#{version}.tar.gz",
    "https://s3.amazonaws.com/nerves/artifacts/nerves_system_bbb-#{version}.tar.gz"],
  build_platform: Nerves.System.Platforms.BR,
  build_config: [
    defconfig: "nerves_defconfig",
    package_files: [
      "bbb-busybox.config",
      "rootfs-additions",
      "fwup.conf",
      "post-createfs.sh"
    ]
  ]
