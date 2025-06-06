defmodule ExVCR.Mixfile do
  use Mix.Project

  @source_url "https://github.com/parroty/exvcr"
  @version "0.17.0"

  def project do
    [
      app: :exvcr,
      version: @version,
      source_url: @source_url,
      elixir: "~> 1.3",
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      test_coverage: [tool: ExCoveralls]
    ]
  end

  def cli do
    [preferred_envs: [coveralls: :test]]
  end

  def application do
    [
      extra_applications: extra_applications(Mix.env()),
      mod: {ExVCR.Application, []}
    ]
  end

  defp extra_applications(:test), do: common_extra_applications()
  defp extra_applications(:dev), do: common_extra_applications()
  defp extra_applications(_), do: []

  defp common_extra_applications do
    [
      :inets,
      :ranch,
      :telemetry,
      :finch,
      :ibrowse,
      :hackney,
      :http_server,
      :httpotion,
      :httpoison,
      :excoveralls
    ]
  end

  def deps do
    [
      {:meck, "~> 1.0"},
      {:exjsx, "~> 4.0"},
      {:ibrowse, "~> 4.4", optional: true},
      {:httpotion, "~> 3.1", optional: true},
      {:httpoison, "~> 1.0 or ~> 2.0", optional: true},
      {:finch, "~> 0.16", optional: true},
      {:excoveralls, "~> 0.18", only: :test},
      {:http_server, github: "parroty/http_server", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    HTTP request/response recording library for elixir, inspired by VCR.
    """
  end

  defp package do
    [
      maintainers: ["parroty"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => @source_url,
        "Changelog" => "#{@source_url}/blob/master/CHANGELOG.md"
      }
    ]
  end

  defp docs do
    [
      main: "readme",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: [
        "CHANGELOG.md",
        "README.md"
      ]
    ]
  end
end
