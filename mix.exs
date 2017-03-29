defmodule Potion.Mixfile do
  use Mix.Project

  def project do
    [app: :potion,
     version: "1.5.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: "utility",
     package: [
       maintainers: ["Yuta Sumiyoshi"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/su-mi-lab/potion"}
     ],
     deps: deps()]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [{:ex_doc, ">= 0.0.0", only: :dev}]
  end
end
