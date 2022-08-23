:test
|> Application.app_dir(["priv", "banner.txt"])
|> File.read!()
|> IO.puts()

# Add Toolshed helpers to the IEx session
use Toolshed
use Test.Helpers
