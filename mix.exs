defmodule DecimalArithmetic.Mixfile do
  use Mix.Project

  def project do
    [
      app: :decimal_arithmetic,
      version: "2.1.0",
      elixir: "~> 1.2",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: "Extended arithmetic for Decimal library.",
      deps: deps()
    ]
  end

  def application do
    []
  end

  defp deps do
    [
      {:decimal, "~> 2.0"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false}
    ]
  end

  defp package do
    [
      contributors: ["Jacek Adamek"],
      maintainers: ["Jacek Adamek"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/jacek-adamek/decimal_arithmetic"}
    ]
  end
end
