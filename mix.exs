defmodule Hlcid.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :hlcid,
      version: @version,
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      description: description(),
      package: package(),
      deps: deps(),
      name: "HLCID",
      source_url: "https://github.com/keathley/hlcid",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {HLCID.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hlclock, "~> 1.0"},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end

  defp description do
    """
    Generates unique, k-ordered ids based on hybrid logical clocks.
    """
  end

  defp package do
    [
      name: "hlcid",
      maintainers: ["Chris Keathley"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/keathley/hlcid"}
    ]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      source_url: "https://github.com/keathley/hlcid",
      main: "HLCID"
    ]
  end
end
