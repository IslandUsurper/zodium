defmodule Zodium.MixProject do
  use Mix.Project

  def project do
    [
      app: :zodium,
      version: "0.1.0",
      elixir: "~> 1.18",
      description: "Zig-compiled libsodium bindings for Elixir",
      source_url: "https://github.com/IslandUsurper/zodium",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:zigler, "~> 0.15", runtime: false}
    ]
  end

  defp package do
    [
      files: ~w(lib .formatter.exs mix.exs README* LICENSE*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/IslandUsurper/zodium"},
      source_url: "https://github.com/IslandUsurper/zodium"
    ]
  end
end
