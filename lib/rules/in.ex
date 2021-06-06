defmodule ElxValidation.In do
  @moduledoc """
     Run Check In or Not In Collection
  """
  @doc """
     target in values [a,b ...]
  """

  def is_in(target, values) do
    v = values
        |> String.split(",")
    Enum.find(v, fn x -> x == target end) != nil
  end
  @doc """
     target not in values [a,b ...]
  """
  def is_not_in(target, values) do
    v = values
        |> String.split(",")
    Enum.find(v, fn x -> x == target end) == nil
  end
end
