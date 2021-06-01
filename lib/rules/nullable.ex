defmodule ElxValidation.Nullable do
  def is_null?(), do: true
  def is_null?(""), do: true
  def is_null?(nil), do: true
  def is_null?(_), do: true

end
