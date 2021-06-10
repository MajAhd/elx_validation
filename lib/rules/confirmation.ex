defmodule ElxValidation.Confirmation do
  @moduledoc """
  ### confirmed
  - The field under validation must have a matching field of {field}_confirmation. For example, if the field under
  validation is password, a matching password_confirmation field must be present in the input.
  ```
  data = %{
      password: "123456",
      password_confirmation: "123456",
  }
  rules = [
      %{
        field: "password",
        validate: ["confirmed"]
      },
  ]
  ```
  """
  @doc """
    confirmation data:
    target :  password
    fields should contain :
        fields[:password]
        fields[:password_confirmation]
    and should equal
  """
  def is_confirmed(target, value) do
    target == value
  rescue
    _ ->
      false
  end
end
