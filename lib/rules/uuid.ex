defmodule ElxValidation.Uuid do
  @moduledoc """
  ### uuid

  - The field under validation must be a valid RFC 4122  universally unique identifier (UUID).

  ```
  data = %{
      uuid_1: "56b2724e-9074-4dc3-9803-4bb13c92ee0e",
      uuid_2: "56b2-9074-4dc3-9803-4bb13c9",   ---> not UUID
  }

  rules = [
      %{
        field: "uuid_1",
        validate: ["uuid"]
      },
     %{
        field: "uuid_2",
        validate: ["uuid"]
      },
    ]
  ```
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
