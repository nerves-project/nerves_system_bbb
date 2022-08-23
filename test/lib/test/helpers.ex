defmodule Test.Helpers do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      import unquote(__MODULE__)
    end
  end

  @doc false
  def sh do
    Nerves.Runtime.Shell.start()
  end
end
