defmodule ElxValidation.Required do
  @moduledoc """
     Run Value Required
  """
  def is_require?(""), do: false
  def is_require?(nil), do: false
  def is_require?(_), do: true

end
