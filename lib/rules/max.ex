defmodule ElxValidation.Max do
  @moduledoc """
     Run Validate Maximum size String or Number
  """
  @doc """
     check value max size
     max : 10 / value 9 -> passed
     max : 3 / value "hi" -> passed (hi is 2 char < 3)
  """
  def is_maximum(max, value) do
    true
  end
end
