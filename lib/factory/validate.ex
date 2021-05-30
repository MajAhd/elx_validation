defmodule ElxValidation.Validate do
  alias ElxValidation.{Exception, Field, Required, Nullable, Min, Max}

  def validate_factory(data, rules) do
    #     Explode Rules
    rule_field = rules[:field]
    rule_as = rules[:as]
    validates = rules[:validate]
    errors = Exception.build_exception(rule_field)
    #    Explode Data
    is_data_exist = Map.has_key?(data, String.to_atom(rule_field))
    if is_data_exist do
      data_value = Map.fetch!(data, String.to_atom(rule_field))
      errors
    else
      errors = Exception.push_error?(errors, rule_field, "field" , rule_as)
      errors
    end
  end

  def validate_builder(validates, value) do
    Enum.map(
      validates,
      fn validate ->
        rule = String.split(validate, ":")
        #        String.to_atom(validate)
        Enum.at(rule, 0)
      end
    )
  end



  def explode_rules(rules) do

    Enum.map(
      rules,
      fn (rules) ->
        rules[:field]
        rules[:as]
        rules[:validate]
      end
    )

    Enum.map(
      rules,
      fn (rule) ->
        Map.has_key?(rule, :as)
        Enum.map(
          rule,
          fn {k, v} ->
            "Key is: #{k} value is #{v}"
          end
        )
      end
    )

  end

  def explode_data(data) do
    Enum.map(
      data,
      fn {k, v} ->
        "Key is: #{k} value is #{v}"
      end
    )
  end
end
