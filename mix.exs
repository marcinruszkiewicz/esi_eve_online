defmodule EsiEveOnline.MixProject do
  use Mix.Project

  @version "0.2.0"

  def project do
    [
      app: :esi_eve_online,
      version: @version,
      name: "ESI EVE Online",
      package: package(),
      elixir: "~> 1.18",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/marcinruszkiewicz/esi_eve_online",
      homepage_url: "https://github.com/marcinruszkiewicz/esi_eve_online",
      description: description(),
      deps: deps(),
      docs: docs(),
      test_coverage: [
        tool: ExCoveralls
      ],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.cobertura": :test
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.5"},
      {:jason, "~> 1.4"},

      # dev and test deps
      {:oapi_generator, "~> 0.2.0", only: [:dev, :test], runtime: false},
      {:mock, "~> 0.3", only: :test},
      {:dialyxir, "~> 1.4", only: :dev, runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:quokka, "~> 2.11", only: [:dev, :test], runtime: false},
      {:doctor, "~> 0.22", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.18", only: :test},

      # docs dependencies
      {:ex_doc, "~> 0.38", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [extras: ["README.md"]]
  end

  defp description do
    "A modern Elixir client for EVE Online's ESI (EVE Swagger Interface) API"
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      maintainers: ["Marcin Ruszkiewicz"],
      licenses: ["MIT"],
      links: %{GitHub: "https://github.com/marcinruszkiewicz/esi_eve_online"}
    ]
  end
end
