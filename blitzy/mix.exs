defmodule Blitzy.MixProject do
  use Mix.Project
  use Mix.Config
  
  config :blitzy, master_node: :"a@127.0.0.1"
  
  config :blitzy, slave_nodes: [:"b@127.0.0.1",
                                :"c@127.0.0.1",
                                :"d@127.0.0.1"]
  def project do
    [
      app: :blitzy,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Blitzy.CLI],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # mod: {Blitzy, []},
      extra_applications: [:logger, :httpoison, :timex]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison,  "~> 1.0.0"},
      {:timex,      "~> 3.1.24"},
      # {:tzdata,     "~> 0.5.16"},
      {:tzdata,     "~> 0.1.8", override: true},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"},
    ]
  end
end
