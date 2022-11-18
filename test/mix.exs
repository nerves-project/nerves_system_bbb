if Mix.env() == :test do
  hash =
    :os.cmd('git rev-parse HEAD')
    |> to_string
    |> String.trim()

  System.put_env("NERVES_FW_VCS_IDENTIFIER", hash)
end

defmodule Test.MixProject do
  use Mix.Project

  @app :test
  @targets [:target]

  def project do
    [
      app: @app,
      name: "system-test",
      description: "System test",
      version: "0.1.0",
      elixir: "~> 1.9",
      archives: [nerves_bootstrap: "~> 1.10"],
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [{@app, release()}],
      aliases: aliases()
    ]
  end

  # Type `mix help compile.app` to learn about applications.
  def application, do: []

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:toolshed, "~> 0.2"},
      {:nerves_runtime, "~> 0.13"},
      {:zola_ca, git: "git@github.com:OffgridElectric/zola_ca.git"},
      {:nerves_system_c2, path: "../", runtime: false, targets: @targets},
      {:shoehorn, "~> 0.8"},
      {:nerves_test_client, git: "git@github.com:OffgridElectric/nerves_test_client.git"},
      {:nerves_key, "~> 1.1", targets: @targets},
      {:nerves_runtime_shell, "~> 0.1.0"}
    ]
  end

  def release do
    [
      overwrite: true,
      cookie: "#{@app}_cookie",
      include_erts: &Nerves.Release.erts/0,
      steps: [&Nerves.Release.init/1, :assemble, &ExUnitRelease.include/1]
    ]
  end

  defp aliases do
    [
      remote_test: [&remote_test/1],
      remote_devtest: [&remote_devtest/1]
    ]
  end

  defp remote_test(args) do
    Mix.shell().cmd("ssh #{test_device_ip(args)} 'Test.run([])'")
  end

  defp remote_devtest(args) do
    path = "/tmp/test"
    localdir = Path.absname(Path.join(__DIR__, "rel/test"))

    batch = """
    mkdir #{path}
    cd #{path}
    lcd #{localdir}
    put -R *
    exit
    """

    ip = test_device_ip(args)

    Mix.shell().cmd("ssh #{ip} 'File.rm_rf(\"#{path}\")'; echo \"#{batch}\" | sftp -b - #{ip}", quiet: true)
    Mix.shell().cmd("ssh #{ip} 'Test.run(path: \"#{path}\")'")
  end

  defp test_device_ip([ip]), do: ip

  defp test_device_ip([]) do
    System.fetch_env!("TEST_DEVICE_IP")
  end
end
