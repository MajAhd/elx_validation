defmodule ElxValidation.Different do
  @moduledoc """
     Run Check Value differences
  """
  @doc """
    target has to different with value
  """
  def is_different(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) != target
      is_bitstring(target) -> value != target
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to equal to value
  """
  def equal(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) == target
      is_bitstring(target) -> value == target
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to greater than value
  """
  def gt(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) < target
      is_bitstring(target) -> String.length(value) < String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to equal or greater than value
  """
  def gte(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) <= target
      is_bitstring(target) -> String.length(value) <= String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to less than value
  """
  def lt(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) > target
      is_bitstring(target) -> String.length(value) > String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to equal or less than value
  """
  def lte(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) >= target
      is_bitstring(target) -> String.length(value) >= String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end

end
