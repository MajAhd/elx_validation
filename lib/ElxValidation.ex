defmodule ElxValidation do
  alias ElxValidation.{Validate}

  def make(data, rules) do

    validation = validations(data, rules)
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

  def validations(data, rules) do

    Enum.map(
      rules,
      fn (rules) ->
        Validate.validate_factory(data, rules)
      end
    )
  end
end
