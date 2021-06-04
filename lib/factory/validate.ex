defmodule ElxValidation.Validate do
  alias ElxValidation.{BindRules, Exception}
  @moduledoc """
  Validator Factory
  Validate all rules
  Response to Validation result
  """
  @doc """
   Explode rules and data
   check field exist
   start validation
  """

  def validate_factory(data, rules) do
    #     Explode Rules
    rule_field = rules[:field]
    rule_as = rules[:as]
    validates = rules[:validate]
    errors = Exception.build_exception(rule_field)
    is_data_exist = Map.has_key?(data, String.to_atom(rule_field))
    if is_data_exist do
      data_value = Map.fetch!(data, String.to_atom(rule_field))
      builder = validate_builder(validates, data_value, rule_field, rule_as, errors)
      builder = Enum.filter(builder, & &1)
      if Enum.count(builder) > 0 do
        err = Exception.response(builder, rule_field)
        List.to_tuple([String.to_atom(rule_field), err])
      end
    else
      builder = Exception.push_error?(errors, rule_field, "field", rule_as)
      err = Exception.response([builder], rule_field)
      List.to_tuple([String.to_atom(rule_field), err])
    end
  end
  @doc """
    check value and rules
    response to validation -> passes or failed
    if failed create errors
  """
  def validate_builder(validates, data_value, rule_field, rule_as, errors) do
    Enum.map(
      validates,
      fn validate ->
        rule = String.split(validate, ":")
        rule_type = Enum.count(rule)
        cond do
          rule_type === 1 ->
            builder = BindRules.build(Enum.at(rule, 0), data_value)
            exception_builder(builder, errors, rule_field, Enum.at(rule, 0), rule_as)
          rule_type === 2 ->
            target = [Enum.at(rule, 1), data_value]
            builder = BindRules.build_multiple(Enum.at(rule, 0), target)
            exception_builder(builder, errors, rule_field, Enum.at(rule, 0), rule_as)
        end
      end
    )
  end
  @doc """
    check if validation builder false push error
  """
  def exception_builder(builder, errors, rule_field, type, rule_as) do
    if !builder do
      Exception.push_error?(errors, rule_field, type, rule_as)
    end
  end
end
