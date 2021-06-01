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
      email: "mjd@yahoo.com",
      accepted: true,
    }

    rules = [
      %{
        field: "name",
        as: "first name",
        validate: ["required", "alpha"]
      },
      %{
        field: "surname",
        validate: ["nullable", "alpha"]
      },
      %{
        field: "email",
        validate: ["required", "string"]
      },
      %{
        field: "accepted",
        validate: ["required", "accepted"]
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
