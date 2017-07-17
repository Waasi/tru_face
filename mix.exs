defmodule TruFace.Mixfile do
  use Mix.Project

  def project do
    [app: :tru_face,
     version: "0.1.2",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     description: description,
     source_url: "https://github.com/Waasi/tru_face",
     package: package,
     docs: [extras: ["README.md"]]]
  end

  def application do
    [applications: [:logger, :httpoison],
     mod: {TruFace, []}]
  end

  defp deps do
    [{:httpoison, "~> 0.12"}, {:poison, "~> 3.1"}, {:mock, "~> 0.2.0", only: :test}, {:ex_doc, ">= 0.0.0", only: :dev}]
  end

  defp description do
    "This is an Elixir library for TrueFace AI"
  end

  defp package do
    [name: :tru_face,
     files: ["lib", "config", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Eric Santos"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/Waasi/tru_face"}]
  end
end
