defmodule ElxValidation.Numbers do
  @moduledoc """
     Run Value Numeric
  """
  @doc """
    target must be a number : integer , float
  """
  def validation_numeric(target) do
    is_number(target)
  end
  @doc """
    target must be a number : integer
    target   12345 -> its 5 digit
    value    5     -> passed
    if value 6     -> failed
  """
  def digits(target, value) do
    cond do
      !is_integer(target) -> false
      !is_integer(String.to_integer(value)) -> false
      Enum.count(Integer.digits(target)) == String.to_integer(value) -> true
      true -> false
    end
  end
end
