defmodule ElxValidation.Max do
  @moduledoc """
  ### max:value
  - The field under validation must be less than or equal to a maximum value.Strings and numerics are evaluated in the
  same fashion as the size rule.
  ```
  data = %{
      name: "john",
      age: 20
  }
  rules = [
      %{
        field: "name",
        validate: ["max:10"]
      },
      %{
        field: "age",
        validate: ["max:40"]
      }
    ]
  ```
  """
  @doc """
     check value max size
     - max : 10 / value 9 -> passed
     - max : 3 / value "hi" -> passed (hi is 2 char < 3)
     - value is string and convert to number
  """
  def is_maximum(target, value) do
    cond do
      is_bitstring(target) -> String.length(target) <= String.to_integer(value)
      is_integer(target) -> target <= String.to_integer(value)
      true -> false
    end
  rescue
    _ ->
      false
  end
end
