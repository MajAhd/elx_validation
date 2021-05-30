defmodule ElxValidation do
  alias ElxValidation.{Validate}

  def make() do
    %{
      errors: validations(),
      failed: true,
    }
  end

  def validations do
    data = %{
      name: "Majid",
      surname: "Ahmadi",
      email: "mjd@yahoo.com"
    }

    rules = [
      %{
        field: "name",
        as: "first name",
        validate: ["required", "string", "max:128"]
      },
      %{
        field: "surname",
        validate: ["nullable", "string", "max:128"]
      },
      %{
        field: "email",
        validate: ["required", "string", "min:5", "max:155"]
      }
    ]
    Enum.map(
      rules,
      fn (rules) ->
        Validate.validate_factory(data, rules)
      end
    )
  end
end
