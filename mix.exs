defmodule TruFace.Mixfile do
  use Mix.Project

  def project do
    [app: :tru_face,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [applications: [:logger, :httpoison],
     mod: {TruFace, []}]
  end

  defp deps do
    [{:httpoison, "~> 0.12"}, {:poison, "~> 3.1"}, {:mock, "~> 0.2.0", only: :test}]
  end
end
