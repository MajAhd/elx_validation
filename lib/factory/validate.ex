defmodule ElxValidation.Validate do
  alias ElxValidation.{BindRules, Exception}
  @moduledoc """
  Validator Factory :
  - Validate all rules
  - Response to Validation result
  - not use inside validator
  - called automatically by validator
  """
  @doc """
   - Explode rules and data
   - check field exist
   - start validation
  """
  def validations(data, rules) do
    Enum.map(
      rules,
      fn (rules) ->
        validate_factory(data, rules)
      end
    )
  end
  def validate_factory(data, rules) do
    #     Explode Rules
    rule_field = rules[:field]
    rule_as = rules[:as]
    validates = rules[:validate]
    errors = Exception.build_exception(rule_field)
    is_data_exist = Map.has_key?(data, String.to_atom(rule_field))
    if is_data_exist do
      builder = validate_builder(validates, data, rule_field, rule_as, errors)
      builder = Enum.filter(builder, & &1)
      if Enum.count(builder) > 0 do
        err = Exception.response(builder, rule_field)
        List.to_tuple([String.to_atom(rule_field), err])
      end
    else
      builder = Exception.push_error?(errors, rule_field, "field", nil, rule_as)
      err = Exception.response([builder], rule_field)
      List.to_tuple([String.to_atom(rule_field), err])
    end
  end
  @doc """
    check value and rules
    response to validation -> passed or failed
    if failed create errors
  """
  def validate_builder(validates, data, rule_field, rule_as, errors) do
    data_value = Map.fetch!(data, String.to_atom(rule_field))
    has_nullable = Enum.find(validates, fn x -> x == "nullable" end)
    # this function initial Validation
    initial_validate = fn ->
      Enum.map(
        validates,
        fn validate ->
          rule = String.split(validate, ":")
          rule_type = Enum.count(rule)
          builder = BindRules.build(validate, data_value, rule_field, data)
          cond do
            rule_type === 1 ->
              exception_builder(builder, errors, rule_field, Enum.at(rule, 0), data_value, rule_as)
            rule_type === 2 ->
              exception_builder(builder, errors, rule_field, Enum.at(rule, 0), Enum.at(rule, 1), rule_as)
          end
        end
      )
    end
    # Check the pre conditions of validation
    cond do
      has_nullable != nil ->
        if data_value == nil or data_value == "" do
          [nil]
        else
          initial_validate.()
        end
      has_nullable == nil -> initial_validate.()
    end
  end

  @doc """
    check if validation builder false push error
  """
  def exception_builder(builder, errors, rule_field, type, data_value, rule_as) do
    if !builder do
      Exception.push_error?(errors, rule_field, type, data_value, rule_as)
    end
  end
end
