defmodule ElxValidation.Alpha do
  @moduledoc """
     Run Check String and Alpha data
  """
  @doc """
    Validate String data
  """
  def is_string(target) do
    is_bitstring(target)
  end
  @doc """
    Validate Only Alpha data [a to z / A to Z]
  """
  def is_alpha(target) do
    Regex.match?(~r/^[A-Za-z]+$/, String.replace(target, " ", ""))
  end
  @doc """
    Validate String starter value :
    target : "code1234" check:code -> passed
  """
  def starts_with(target, check) do  end
  @doc """
    Validate String end value :
    target : "1234code" check:code -> passed
  """
  def ends_with(target, check) do  end
end
