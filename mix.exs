defmodule DecimalArithmetic.Mixfile do
  use Mix.Project

  def project do
    [app: :decimal_arithmetic,
     version: "0.1.2",
     elixir: "~> 1.1",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package(),
     description: "Extended arithmetic for Decimal library.",
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:decimal, "~> 1.5"},
      {:ex_doc, "~> 0.18", only: :dev},
      {:earmark, "~> 1.2", only: :dev},
      {:mix_test_watch, "~> 0.5", only: :dev},
      {:dialyxir, "~> 0.5", only: :dev}
    ]
  end

  defp package do
    [ contributors: ["Jacek Adamek"],
      maintainers: ["Jacek Adamek"],
      licenses: ["MIT"],
      links: %{ "Github" => "https://github.com/jacek-adamek/decimal_arithmetic" } ]
  end
end
