defmodule ElxValidation do
  alias ElxValidation.Validate
  @moduledoc """
  Main module to start Validation.
  - `make` function for start validation
  """

  @doc """
  Starts ElxValidation.
     - ElxValidation.make(data , rules)
  """
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

  @doc """
     send all data to rules to check and validate rules /value
  """
  def validations(data, rules) do
    Enum.map(
      rules,
      fn (rules) ->
        Validate.validate_factory(data, rules)
      end
    )
  end
end
