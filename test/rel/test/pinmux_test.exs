defmodule PinmuxTest do
  use ExUnit.Case

  defmacro assert_pin(pins_data, match) do
    quote do
      if Enum.any?(unquote(pins_data), &String.match?(&1, ~r/^#{Regex.escape(unquote(match))}/)) do
        assert true
      else
        flunk("""
        No pinmux-pins data matching:

          #{unquote(match)}

        """)
      end
    end
  end

  setup_all _ctx do
    _ = System.cmd("mount", ~w(-t debugfs none /sys/kernel/debug))
    [pins_path] = Path.wildcard("/sys/kernel/debug/pinctrl/*/pinmux-pins")
    pins = pins_path |> File.read!() |> String.split("\n", trim: true)

    [pins: pins]
  end

  describe "pinmux configuration" do
    test "DCAN0", %{pins: pins} do
      assert_pin(
        pins,
        "pin 94 (PIN94): 481cc000.can (GPIO UNCLAIMED) function pinmux_dcan0_pins group pinmux_dcan0_pins"
      )

      assert_pin(
        pins,
        "pin 95 (PIN95): 481cc000.can (GPIO UNCLAIMED) function pinmux_dcan0_pins group pinmux_dcan0_pins"
      )
    end

    test "DCAN1", %{pins: pins} do
      assert_pin(
        pins,
        "pin 90 (PIN90): 481d0000.can (GPIO UNCLAIMED) function pinmux_dcan1_pins group pinmux_dcan1_pins"
      )

      assert_pin(
        pins,
        "pin 91 (PIN91): 481d0000.can (GPIO UNCLAIMED) function pinmux_dcan1_pins group pinmux_dcan1_pins"
      )
    end

    test "MMC1", %{pins: pins} do
      assert_pin(
        pins,
        "pin 60 (PIN60): 48060000.mmc (GPIO UNCLAIMED) function pinmux_mmc1_pins group pinmux_mmc1_pins"
      )

      assert_pin(
        pins,
        "pin 61 (PIN61): 48060000.mmc (GPIO UNCLAIMED) function pinmux_mmc1_pins group pinmux_mmc1_pins"
      )

      assert_pin(
        pins,
        "pin 62 (PIN62): 48060000.mmc (GPIO UNCLAIMED) function pinmux_mmc1_pins group pinmux_mmc1_pins"
      )

      assert_pin(
        pins,
        "pin 63 (PIN63): 48060000.mmc (GPIO UNCLAIMED) function pinmux_mmc1_pins group pinmux_mmc1_pins"
      )

      assert_pin(
        pins,
        "pin 64 (PIN64): 48060000.mmc (GPIO UNCLAIMED) function pinmux_mmc1_pins group pinmux_mmc1_pins"
      )

      assert_pin(
        pins,
        "pin 65 (PIN65): 48060000.mmc (GPIO UNCLAIMED) function pinmux_mmc1_pins group pinmux_mmc1_pins"
      )
    end

    # test "RS485_1(UART1)"

    test "UART3", %{pins: pins} do
      assert_pin(
        pins,
        "pin 88 (PIN88): 481a6000.serial (GPIO UNCLAIMED) function uart3_pins group uart3_pins"
      )

      assert_pin(
        pins,
        "pin 89 (PIN89): 481a6000.serial (GPIO UNCLAIMED) function uart3_pins group uart3_pins"
      )
    end

    # test "RS485_1(UART4)"

    test "PWM1/BUZZER", %{pins: pins} do
      assert_pin(
        pins,
        "pin 18 (PIN18): 48302200.pwm (GPIO UNCLAIMED) function pinmux_P9_14_pwm_pin group pinmux_P9_14_pwm_pin"
      )
    end

    test "I2C1/ATECC", %{pins: pins} do
      assert_pin(
        pins,
        "pin 86 (PIN86): 4802a000.i2c (GPIO UNCLAIMED) function pinmux_P9_18_i2c_pin group pinmux_P9_18_i2c_pin"
      )

      assert_pin(
        pins,
        "pin 87 (PIN87): 4802a000.i2c (GPIO UNCLAIMED) function pinmux_P9_17_i2c_pin group pinmux_P9_17_i2c_pin"
      )
    end

    test "I2C2 (not used)", %{pins: pins} do
      assert_pin(
        pins,
        "pin 98 (PIN98): 44e0b000.i2c (GPIO UNCLAIMED) function pinmux_i2c0_pins group pinmux_i2c0_pins"
      )

      assert_pin(
        pins,
        "pin 99 (PIN99): 44e0b000.i2c (GPIO UNCLAIMED) function pinmux_i2c0_pins group pinmux_i2c0_pins"
      )
    end
  end
end
