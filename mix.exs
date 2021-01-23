defmodule Bday.MixProject do
  use Mix.Project

  def project do
    [
      app: :bday,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env),
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:propcheck, "~> 1.1", only: [:test, :dev]}
    ]
  end

  # Specifies which paths to compile per environment.
  # https://adamdelong.com/elixir-module-not-available/
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]
end
