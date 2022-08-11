import Config

# Repository specific configuration

platform = "bbb"
arch = "arm"

app_part_devparth = "/dev/mmcblk0p4"

# Environment specific configuration
#  Nerves Project test farm configuration
#  NERVES_TEST_SERVER = nerves-test-server.herokuapp.com
#  WEBSOCKET_PROTOCOL = wss

test_server = System.get_env("NERVES_TEST_SERVER", "zola-nerves-test.herokuapp.com")
websocket_protocol = System.get_env("WEBSOCKET_PROTOCOL", "ws")

Application.start(:nerves_bootstrap)
# Common configuration

# Configure shoehorn boot order.
config :shoehorn,
  app: :nerves_system_test,
  init: [:nerves_runtime, :vintage_net]

# Code.compile_file(Path.join(__DIR__, "nm_wifi.exs"))
import_config "nm_wifi.exs"
networks = Config.NmWifi.networks(System.get_env("WIFI_NETWORKS", ""))

config :vintage_net,
  regulatory_domain: System.get_env("NERVES_REGULATORY_DOMAIN", "us"),
  config: [
    {"eth0", %{type: VintageNet.Technology.Ethernet, ipv4: %{method: :dhcp}}},
    {"wlan0",
     %{
       type: VintageNetWiFi,
       ipv4: %{method: :dhcp},
       vintage_net_wifi: %{networks: networks}
     }}
  ]

config :nerves_ssh,
  authorized_keys: [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCn4SWRN06jaYaI8j3Hn+GB5wHXkhxQjzlqLS/Vu7McYH9fenco6KBCiFFfBJ5jZuPOIYYB1Bcwg1GPljtC4tNTSJZIVJlujQx8dSA/g4u4Aslzjj7od7IXhAhZ6ks5qSiycmEWZZTB8HW60gcbXfOoWmbfVc07Aedc/bdj3talQBmK7UmSvPpUcKv+t2wv9R/IoBASbTTd/zjuUUBmqgMBYvLPa9DtEOTzuWM9ukBEBSQTrHYfJldgIkJRDkCRXFtVcJrO58EEtTdvGcl7rDnAXqnhHttiCpMdjjTdNzGJEIgOd5Mukh9FhWf0gWij8A0Jkv6E1osvrXz9ZPItYteB jgiffin",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbwMpJhNIVECuuggxX8zefr6Ufb56d+Zx2MPANNxRUh jean",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDf7zLrhnU++h/L8F4XhQoG9I1/0DCHe8iRMYXU9ThFpZ1Rm6D9OzrxfcjuMVCdbIGYox7XWkguALOgVOvXh+Fx3fP6+bTAmobUq/PwrnB7k0I9yf7flqKLyXh8/hkn2UmUDFxRSKVy0FkYq15UeaWotvrP0W+R2Vbw20y7wnaeKU9Zn7TPgSiSatDm49BxTChvhS522sj7Vvp+aYGMXKa609mBoSqDrv3ghU9auFLTOcv86Bsrz5bBwlrxKP6hDSXYl/x6fAg+LeOAuHXYpvXyx45flknZ1OT2SmhPcZCHBbjm+PhrKt+pfAJy0qrz2K66h0QU4BkhNc7nrFO6VN05 pi@raspberrypi"
  ]

# Configure the url for the connection to the test server phoenix channel socket.
config :nerves_test_client, url: "#{websocket_protocol}://#{test_server}/socket/websocket"

# The configuration stored here is duplicated from the project so it can be
#  validated by nerves_test_client because the source is unavailable at runtime.
config :nerves_runtime, :kv,
  nerves_fw_application_part0_devpath: app_part_devparth,
  nerves_fw_application_part0_fstype: "f2fs",
  nerves_fw_application_part0_target: "/root",
  nerves_fw_architecture: arch,
  nerves_fw_author: "The Nerves Team",
  nerves_fw_description: Mix.Project.config()[:description],
  nerves_fw_platform: platform,
  nerves_fw_product: Mix.Project.config()[:name],
  nerves_fw_vcs_identifier: System.get_env("NERVES_FW_VCS_IDENTIFIER"),
  nerves_fw_version: Mix.Project.config()[:version]

nerves_hub_host = "nerves-hub-staging.zolaelectric.com"
nerves_hub_port = 443

# if Mix.target() != :host do
#   config :nerves_hub_link,
#     device_api_host: "device.#{nerves_hub_host}",
#     device_api_sni: "device.#{nerves_hub_host}",
#     device_api_port: nerves_hub_port,
#     ca_store: NervesTestClient.CAStore,
#     fwup_public_keys: [System.fetch_env!("FW_SIGNING_PUBKEY")]

#   config :nerves_hub_user_api,
#     host: "api.#{nerves_hub_host}",
#     port: nerves_hub_port,
#     server_name_indication: 'api.#{nerves_hub_host}',
#     ca_store: NervesTestClient.CAStore

#   config :nerves_hub_cli, org: "zola"
# end
