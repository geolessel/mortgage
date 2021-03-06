defmodule Mortgage.Mixfile do
  use Mix.Project

  def project do
    [app: :mortgage,
     version: "0.0.2",
     elixir: "~> 1.2",
     description: description,
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:mix_test_watch, "~> 0.2", only: :dev}
    ]
  end

  defp description do
    """
    A set of functions for working with mortgages and mortgage notes.
    """
  end

  defp package do
    [
      licenses: ["Apache 2.0"],
      maintainers: ["Geoffrey Lessel"],
      links: %{
        "GitHub" => "https://github.com/geolessel/mortgage"
      }
    ]
  end
end
