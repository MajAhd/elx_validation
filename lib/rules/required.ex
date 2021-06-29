defmodule ElxValidation.Required do
  alias ElxValidation.Field
  @moduledoc """
  ### required
  - The field under validation must be present in the input data and not empty. A field is considered "empty" if one of
  the following conditions are true:
    - The value is null.
    - The value is an empty string.

  ### required_if:anotherfield
     - The field under validation must be present and not empty if the anotherfield field is exist and equal to any value.

  ### required_unless:anotherfield
     - The field under validation must be present and not empty unless the anotherfield is Not Exist or be null or empty or "" value.

  ***

  ```
  data = %{
       first_name: "John",
       mid_name: "",  --> return error
       last_name: "doe", --> required if first_name defined and has any value
       email: "email@example.com",
       phone: "+123456789",   --> if email not exist or has null or "" value the phone field is required

  }

  rules = [
      %{
        field: "name",
        validate: ["required"]
      },
      %{
        field: "mid_name",
        validate: ["required"]
      },
     %{
        field: "last_name",
        validate: ["required_if:first_name"]
      },

     %{
        field: "email",
        validate: ["nullable" , "email"]
      },
     %{
        field: "phone",
        validate: ["required_unless:email"]
      }
    ]
  ```

  ***
  - mid_name defined "required" so null , empty string not excepted
  - it returns error:  "The mid_name field is required."

  """
  def is_require?(""), do: false
  def is_require?(nil), do: false
  def is_require?(_), do: true
  def required_if(req_field, all_data, value) do
    if Field.field_exist?(req_field, all_data) do
      check_point = Map.fetch!(all_data, String.to_atom(req_field))
      if is_require?(check_point) do
        is_require?(value)
      else
        true
      end
    else
      true
    end
  end
  def required_unless(req_field, all_data, value) do
    if Field.field_exist?(req_field, all_data) do
      check_point = Map.fetch!(all_data, String.to_atom(req_field))
      if is_require?(check_point) do
        false
      else
        is_require?(value)
      end
    else
      is_require?(value)
    end
  end

  def required_with do
    true
  end

  def required_without do
    true
  end
end
