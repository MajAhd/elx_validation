defmodule ElxValidation.Field do
  @moduledoc """
     Run Check field exist on data
  """
  def field_exist?(nil), do: false
  def field_exist?(field_name, data) do
    Map.has_key?(data, String.to_atom(field_name))
  end
end
