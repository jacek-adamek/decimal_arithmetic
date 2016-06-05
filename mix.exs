defmodule DecimalArithmetic.Mixfile do
  use Mix.Project

  def project do
    [app: :decimal_arithmetic,
     version: "0.1.1",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     description: "Extended arithmetic for Decimal library.",
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:decimal, "~> 1.1"},
      {:ex_doc, "~> 0.11.0", only: :dev},
      {:earmark, "~> 0.1", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev},
      {:dialyxir, "~> 0.3", only: :dev}
    ]
  end

  defp package do
    [ contributors: ["Jacek Adamek"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/jacek-adamek/decimal_arithmetic" } ]
  end
end
