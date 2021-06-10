defmodule ElxValidation.Min do
  @moduledoc """
     Run Validate Minimum size String or Number
  """
  @doc """
     check value min size
     max : 3 / value 4 -> passed
     max : 3 / value "hello" -> passed (hi is 5 char > 3)
  * value is string and convert to number
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
