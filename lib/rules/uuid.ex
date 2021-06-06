defmodule ElxValidation.Uuid do
  @moduledoc """
     Run Validate UUID
  """
  @doc """
    check target is uuid
  """
  def is_uuid(target) do
    uuid_rfc_4122(target)
  end

  def uuid_rfc_4122(target) do
    Regex.match?(~r/[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}/, target)
  end
end
