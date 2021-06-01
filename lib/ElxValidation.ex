defmodule ElxValidation do
  alias ElxValidation.{Validate}

  def make() do
    validation = validations()
    validation = Enum.filter(validation, & &1)
    %{
      errors: if Enum.count(validation) > 0 do
        validation
      else
        []
      end,
      failed: if Enum.count(validation) > 0 do
        true
      else
        false
      end,
    }
  end

  def validations do
    data = %{
      name: "Majid",
      surname: "Ahmadi",
      email: "majid@site.com",
      app_privacy: true,
    }

    rules = [
      %{
        field: "name",
        as: "first name",
        validate: ["required", "alpha"]
      },
      %{
        field: "surname",
        validate: ["required", "alpha"]
      },
      %{
        field: "email",
        validate: ["required", "string"]
      },
      %{
        field: "app_privacy",
        as: "Term of Privacy",
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
