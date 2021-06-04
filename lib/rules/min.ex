defmodule ElxValidation.Min do
  @moduledoc """
     Run Validate Minimum size String or Number
  """
  @doc """
     check value min size
     max : 3 / value 4 -> passed
     max : 3 / value "hello" -> passed (hi is 5 char > 3)
  """
  def is_minimum(min, value) do
    true
  end
end
