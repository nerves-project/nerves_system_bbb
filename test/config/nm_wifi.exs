
defmodule Config.NmWifi do
  @moduledoc """
  Decode wifi networks from ./export_nm_wifi.sh output
  """
  def networks(nil), do: []

  def networks(data) when is_binary(data) do
    data
    |> String.split(":", trim: true)
    |> Enum.map(fn encoded ->
      encoded
      |> Base.decode64!()
      |> String.split("\n")
      |> Enum.reduce(%{}, fn line, acc ->
        item = String.split(line, "=", trim: true, parts: 2)
        build_network(item, acc)
      end)
    end)
    |> Enum.filter(fn
      %{key_mgmt: :wpa_psk} -> true
      _ -> false
    end)
  end

  defp build_network(["wifi.ssid", ssid], acc), do: Map.put(acc, :ssid, ssid)
  defp build_network(["wifi-security.key-mgmt", "wpa-psk"], acc), do: Map.put(acc, :key_mgmt, :wpa_psk)
  defp build_network(["wifi-security.psk", psk], acc), do: Map.put(acc, :psk, psk)
  defp build_network(_, acc), do: acc
end
