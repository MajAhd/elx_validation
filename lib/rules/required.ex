defmodule ElxValidation.Required do
  @moduledoc """
  ### required
  - The field under validation must be present in the input data and not empty. A field is considered "empty" if one of
  the following conditions are true:
    - The value is null.
    - The value is an empty string.

  ***

  ```
  data = %{
        first_name: "Majid"
  }
  rules = [
      %{
        field: "name",
        validate: ["required"]
      }
    ]
  ```

  - rules defined by "name" but data defined by "first name"
  - it returns error:  "The name is not exist"


  ```
  data = %{
      name: ""
  }
  rules = [
      %{
        field: "name",
        validate: ["required"]
      }
    ]
  ```
  ***
  - rules defined "required" so null , empty string not excepted
  - it returns error:  "The name field is required."

  """
  def is_require?(""), do: false
  def is_require?(nil), do: false
  def is_require?(_), do: true

end
