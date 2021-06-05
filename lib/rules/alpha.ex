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
  def start_with(target, start_value) do
    check_string = is_string(target)
    if check_string do
      compare = String.slice(target , 0.. String.length(start_value)-1)
      compare == start_value
    else
      check_string
    end
  end
  @doc """
    Validate String end value :
    target : "1234code" check:code -> passed
  """
  def end_with(target, end_value) do
    check_string = is_string(target)
    if check_string do
      end_value
    else
      check_string
    end
  end
end
