defmodule SeaweedfsRepro.Mixfile do
  use Mix.Project

  def project do
    [app: :seaweedfs_repro,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [
      mod: {SeaweedfsRepro, []},
      applications: [:logger, :httpoison, :parallel]
    ]
  end

  defp deps do
    [
      {:calendar, "~> 0.12.4"},
      {:httpoison, "~> 0.8.2"},
      {:parallel, github: "eproxus/parallel"}
    ]
  end
end
