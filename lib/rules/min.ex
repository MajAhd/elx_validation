defmodule ElxValidation.Min do
  @moduledoc """
  ### min:value
  - The field under validation must have a minimum value. Strings and numerics are evaluated in the same fashion as the
  size rule.

  ```
  data = %{
      name: "john",
      age: 19  ---> return error minimum value is 20
  }
  rules = [
      %{
        field: "name",
        validate: ["min:3"]
      },
      %{
        field: "age",
        validate: ["min:20"]
      }
    ]
  ```
  """
  @doc """
     check value min size
    - min : 3 / value 4 -> passed
    - min : 3 / value "hello" -> failed (hello is 5 char > 3)
    - value is string and convert to number
  """
  def is_minimum(target, value) do
    cond do
      is_bitstring(target) -> String.length(target) >= String.to_integer(value)
      is_integer(target) -> target >= String.to_integer(value)
      true -> false
    end
  rescue
    _ ->
      false
  end
end
