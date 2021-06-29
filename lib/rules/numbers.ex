defmodule ElxValidation.Numbers do
  @moduledoc """
  ### numeric
  - The field under validation must be numeric.

  ```
  data = %{
       number1: 2121,
       number2: "2121"  ----> return error
    }
  rules = [
     %{
        field: "number1",
        validate: ["numeric"]
      },
      %{
        field: "number2",
        validate: ["numeric"]
      }
  ]
  ```
  ***
  ### digits:value
  - The field under validation must be numeric and must have an exact length of value.

  ```
  data = %{
      age1: 12,
      age2: 9  ---> return error min 2 digit required
  }
  rules = [
      %{
        field: "age1",
        validate: ["digits:2"]
      },
     %{
        field: "age2",
        validate: ["digits:2"]
      }
  ]
  ```
  """
  @doc """
    target must be a number : integer , float
  """
  def validation_numeric(target) do
    is_number(target)
  rescue
    _ ->
      false
  end
  @doc """
    target must be a number : integer
    target   12345 -> its 5 digit
    value    5     -> passed
    if value 6     -> failed
  ** value is string because it comes from validation object
  """
  def digits(target, value) do
    cond do
      !is_integer(target) -> false
      !is_integer(String.to_integer(value)) -> false
      Enum.count(Integer.digits(target)) == String.to_integer(value) -> true
      true -> false
    end
  rescue
    _ ->
      false
  end
end
