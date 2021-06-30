defmodule ElxValidation.In do
  @moduledoc """
  ### in:foo,bar,...
  - The field under validation must be included in the given list of values.

  ### not_in:foo,bar,...
  - The field under validation must not be included in the given list of values.
  ```
  data = %{
      country: "italy",
      grade: "a",
  }
  rules = [
      %{
        field: "country",
        validate: ["in:iran,italy,usa"]
      },
      %{
        field: "grade",
        validate: ["not_in:c,d,e", "in:a,b"]
      }
  ]
  ```
  """
  @doc """
     target in values [a,b ...]
  """

  def is_in(target, values) do
    v = values
        |> String.split(",")
    Enum.find(v, fn x -> x == target end) != nil
  rescue
    _ ->
      false
  end
  @doc """
     target not in values [a,b ...]
  """
  def is_not_in(target, values) do
    v = values
        |> String.split(",")
    Enum.find(v, fn x -> x == target end) == nil
  rescue
    _ ->
      false
  end
end
