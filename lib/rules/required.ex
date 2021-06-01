defmodule ElxValidation.Required do

  def is_require?(), do: false
  def is_require?(""), do: false
  def is_require?(nil), do: false
  def is_require?(_), do: true

end
