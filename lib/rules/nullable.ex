defmodule ElxValidation.Nullable do
  @moduledoc """
  ### nullable
  - The field under validation may be null.

  ```
  data = %{
      optional_name: "majid",
  }
  rules = [
      %{
        field: "optional_name",
        validate: ["nullable" , "alpha" , "min:3"] --> nullable rule as first rule of validation
      },
  ]
  ```
  """
  def is_null?(""), do: true
  def is_null?(nil), do: true
  def is_null?(_), do: true

end
