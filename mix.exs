defmodule Combin.Mixfile do
  use Mix.Project

  def project do
    [app: :lib_combin,
     version: "0.1.2",
     elixir: "~> 1.4.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     description: description(),
     package: package(),
     deps: deps()]
  end

  def application do
    []
  end

  defp deps do
    []
  end

  defp description do
    """
    Basic combinatorics for Erlang lists.
    """
  end

  defp package do
    [# These are the default files included in the package
     name: :lib_combin,
     files: ["lib", "priv", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     maintainers: ["Jorgen Brandt"],
     licenses: ["Apache 2.0"],
     links: %{"GitHub" => "https://github.com/joergen7/lib_combin"}]
  end
end