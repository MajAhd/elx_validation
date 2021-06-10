defmodule ElxValidation.Uuid do
  @moduledoc """
     Run Validate UUID
  """
  @doc """
    check target is uuid
  """
  def is_uuid(target) do
    uuid_rfc_4122(target)
  rescue
    _ ->
      false
  end
  @doc """
    RFC 4122
    - 0-9 or a-f 8 char
    - 0-9 or a-f 4 char
    - 0-9 or a-f 4 char
    - 0-9 or a-f 4 char
    - 0-9 or a-f 12 char
  """
  def uuid_rfc_4122(target) do
    Regex.match?(~r/[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}/, target)
  rescue
    _ ->
      false
  end
end
