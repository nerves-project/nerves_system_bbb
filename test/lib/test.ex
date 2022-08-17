defmodule Test do
  @moduledoc false

  def run(opts) do
    opts
    |> Keyword.put(:autorun, false)
    |> ExUnit.configure()

    path = opts[:path] || runtime_include_path()

    case require_test_helper(path) do
      :ok ->
        tests = test_files([path])
        require_and_run(tests)

      error ->
        error
    end
  end

  defp runtime_include_path() do
    :code.root_dir()
    |> to_string()
    |> Path.join("test")
  end

  defp require_test_helper(path) do
    file = Path.join(path, "test_helper.exs")

    if File.exists?(file) do
      Code.require_file(file)
      :ok
    else
      {:error, "Cannot run tests because test helper file #{inspect(file)} does not exist"}
    end
  end

  defp test_files(paths) do
    pattern = "*_test.exs"

    Enum.flat_map(paths, fn path ->
      case :elixir_utils.read_file_type(path) do
        {:ok, :directory} -> Path.wildcard("#{path}/**/#{pattern}")
        {:ok, :regular} -> [path]
        _ -> []
      end
    end)
    |> Enum.uniq()
  end

  defp require_and_run(files) do
    with {:ok, pid} <- Agent.start_link(fn -> [] end),
         {:ok, _, _} <-
           Kernel.ParallelCompiler.require(files, each_module: &each_module(pid, &1, &2, &3)) do
      task = Task.async(ExUnit, :run, [])

      try do
        {:ok, Task.await(task, :infinity)}
      catch
        _kind, reason ->
          Task.shutdown(task)
          {:error, reason}
      after
        Agent.get(pid, & &1)
        |> unload_modules()

        Agent.stop(pid)
      end
    end
  end

  def unload_modules(modules) do
    Enum.each(modules, fn {mod, file} ->
      :code.delete(mod)
      :code.purge(mod)
      Code.unrequire_files([file])
    end)
  end

  defp each_module(pid, file, module, _binary) do
    Agent.update(pid, &[{module, file} | &1])
  end
end
