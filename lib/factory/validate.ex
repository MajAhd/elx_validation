defmodule ElxValidation.Validate do
  alias ElxValidation.{BindRules, Exception}

  def validate_factory(data, rules, lang \\ "en") do
    #     Explode Rules
    rule_field = rules[:field]
    rule_as = rules[:as]
    validates = rules[:validate]
    errors = Exception.build_exception(rule_field)
    #    Explode Data
    is_data_exist = Map.has_key?(data, String.to_atom(rule_field))
    if is_data_exist do
      data_value = Map.fetch!(data, String.to_atom(rule_field))
      validate_builder(validates, data_value, rule_field, rule_as, errors)
    else
      Exception.push_error?(errors, rule_field, "field", rule_as)
    end
  end

  def validate_builder(validates, data_value, rule_field, rule_as, errors) do
    Enum.map(
      validates,
      fn validate ->
        rule = String.split(validate, ":")
        rule_type = Enum.count(rule)
        cond do
          rule_type === 1 ->
            builder = BindRules.build(Enum.at(rule, 0), data_value)
            if !builder do
              Exception.push_error?(errors, rule_field, Enum.at(rule, 0), rule_as)
            else
              errors
            end
          rule_type === 2 ->
            target = [Enum.at(rule, 1), data_value]
            errors = BindRules.build(Enum.at(rule, 0), target)
        end
      end
    )
  end
end
