defmodule ElxValidation.Max do
  @moduledoc """
     Run Validate Maximum size String or Number
  """
  @doc """
     check value max size
     max : 10 / value 9 -> passed
     max : 3 / value "hi" -> passed (hi is 2 char < 3)
   * value is string and convert to number
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
