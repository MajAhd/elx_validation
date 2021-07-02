defmodule ElxValidation.Required do
  alias ElxValidation.Field
  @moduledoc """
  ### Required
  - The field under validation must be present in the input data and not empty. A field is considered "empty" if one of
  the following conditions are true:
    - The value is null.
    - The value is an empty string.

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
  #### rules defined by "name" but data defined by "first name"
  #### it returns error:  "The name is not exist"
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
  #### rules defined "required" so null , empty string not excepted
  #### it returns error:  "The name field is required."
  ***
  ### Required If
     - required_if:anotherfield
       - The field under validation must be present and not empty if the anotherfield field is exist and equal to any value.

  ```
  data = %{
    first_name: "Majid",
    last_name: "Ahmadi" ---> if first_name exist and has value last_name field is required
  }
  rules = [
      %{
        field: "first_name",
        validate: ["nullable", "string" , "max:50"]
      },
     %{
        field: "last_name",
        validate: ["required_if:first_name"]
      }
    ]
  ```
  ***
  ### Required Unless
  - required_unless:anotherfield
     - The field under validation must be present and not empty unless the anotherfield is Not Exist or be null or empty or "" value.

  ```
  data = %{
    email: "email@example.com",
    phone: "+123456789" ---> if email not exist or has null or "" value the phone field is required
  }
  rules = [
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
  ### Required with
  - required_with:foo,bar,...
    - The field under validation must be present and not empty only if any of the other specified fields are present and not empty.

  ```
  data = %{
       first_name: "John",
       last_name: "doe", --> required if first_name defined and has any value
       full_name: "required_with:first_name,last_name" -->required if first_name,last_name is exist or not empty
  }
  rules = [
      %{
        field: "first_name",
        validate: ["required"]
      },
     %{
        field: "last_name",
        validate: ["required_if:first_name"]
      },
      %{
        field: "full_name",
        validate: ["required_with:first_name,last_name"]
      }
    ]
  ```
  ***
  ### Required Without
  - required_without:foo,bar,...
    - The field under validation must be present and not empty only when any of the other specified fields are empty or not present.

  ```
  data = %{
       first_name: "",
       last_name: "",
       full_name: "John Dow" -->required if first_name,last_name is/are not exist or empty
  }

  rules = [
      %{
        field: "first_name",
        validate: ["nullable" , "alpha"]
      },
     %{
        field: "last_name",
        validate: ["nullable" , "alpha"]
      },
      %{
        field: "full_name",
        validate: ["required_with:first_name,last_name"]
      }
    ]
  ```
  ***
  ### important notice
     - if you use required if , unless ,with and without, validator will validates all rules that you set

  ```
    data = %{
      first_name: "John",
      last_name: "doe" --> alpha , min and max will validate
    }

    rules = [
      %{
        field: "first_name",
        validate: ["nullable", "alpha", "min:3", "max:10"]
      },
      %{
        field: "last_name",
        validate: ["required_if:first_name" , "alpha", "min:3", "max:10"]
      }
    ]
  ```
  ### the logic is :
  #### if first_name has value then last_name is required
  #### if first_name hasn't value then last_name is not required
  #### in case first_name does not exist or null last_name is not necessary but alpha and min and max validations still works.
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
        true
      else
        is_require?(value)
      end
    else
      is_require?(value)
    end
  end

  def required_with(req_fields, all_data, value) do
    fields = String.split(req_fields, ",")
    check_fields = fn () -> Enum.map(
                              fields,
                              fn (field) ->
                                if Field.field_exist?(field, all_data) do
                                  check_point = Map.fetch!(all_data, String.to_atom(field))
                                  if is_require?(check_point) do
                                    is_require?(value)
                                  else
                                    true
                                  end
                                else
                                  true
                                end
                              end
                            )
    end
    Enum.reduce(check_fields.(), true, fn x, acc -> x and acc end)
  end

  def required_without(req_fields, all_data, value) do
    fields = String.split(req_fields, ",")
    check_fields = fn -> Enum.map(
                           fields,
                           fn (field) ->
                             if Field.field_exist?(field, all_data) do
                               check_point = Map.fetch!(all_data, String.to_atom(field))
                               if is_require?(check_point) do
                                 true
                               else
                                 is_require?(value)
                               end
                             else
                               is_require?(value)
                             end
                           end
                         )
    end
    Enum.reduce(check_fields.(), true, fn x, acc -> x and acc end)
  end
end
