defmodule ElxValidation.MixProject do
  use Mix.Project

  def project do
    [
      app: :elx_validation,
      version: "0.1.0",
      elixir: "~> 1.11",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    Library for Validation data.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*" ,"CHANGELOG*"],
      maintainers: ["Majid Ahmaditabar"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/MajAhd/elx_validation",
        "Wiki" => "https://github.com/MajAhd/elx_validation/wiki"
      }
    ]
  end
end
