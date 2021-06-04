defmodule ElxValidation.Field do
  @moduledoc """
     Run Check field exist on data
  """
  def field_exist?(nil), do: false
  def field_exist?(_), do: true
end
