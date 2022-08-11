defmodule Test do
  @moduledoc false

  def run do
    ExUnitRelease.run()
    |> case do
      {:ok, {out, results}} ->
        IO.puts(out)
        IO.puts("\n")
        IO.puts("""
        * Excluded: #{results.excluded}
        * Failures: #{results.failures}
        * Skipped:  #{results.skipped}
        * Total:    #{results.total}
        """)
    end
  end
end
