defmodule ElxValidation do
  alias ElxValidation.Validate

  @moduledoc """
  ### Elx Validation
    - Easy and Simple Data validator.
    - `make` function for start validation
    - [ElxValidation Github Wiki Page](https://github.com/MajAhd/elx_validation/wiki)
  ***
  ### install
  ```
  mix.exs
     {:elx_validation, "~> 0.1.3"}
  mix deps.get
  ```
  ***
  ### How To use
  ```
  example_data = %{
    first_name: "Majid"
  }
  rules = [
     %{
        field: "first_name",
        as: "first name",
        validate: ["required", "string", "max:128"].
      },
  ]
  ```
  #### field : The Field name that need to validate
  #### as :  its optional and use for response error
  #### validate : list of rules and validations
  ### Run Validation : ` ElxValidation.make(example_data ,  rules) `
  ### Validator has Error
  ```
  %{
      errors: [
         name: ["Error Message" , "Error Message"]
      ],
      failed: true
  }
  ```
  ### Validator without Error:
  ```
  %{
     errors: [],
     failed: false
  }
  ```
  """
  def make(data, rules) do
    validation = Validate.validations(data, rules)
    validation = Enum.filter(validation, & &1)

    %{
      errors:
        if Enum.count(validation) > 0 do
          validation
        else
          []
        end,
      failed:
        if Enum.count(validation) > 0 do
          true
        else
          false
        end
    }
  end
end
