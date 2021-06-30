defmodule ElxValidation.BindRules do
  alias ElxValidation.{Accepted, Alpha, Boolean, Field, In, Internet, Max, Min, Nullable, Numbers}
  alias ElxValidation.{Confirmation, DateTime, Different, Required, Uuid}
  @moduledoc """
    Build rules by rule name
  - not use inside validator
  - called automatically by validator
  """
  def build(validate, value, rule_field, all_data) do
    rule = String.split(validate, ":")
    action = Enum.at(rule, 0)
    cond do
      #      Rules
      action == "required" -> Required.is_require?(value)
      action == "required_if" -> Required.required_if(Enum.at(rule, 1), all_data , value)
      action == "required_unless" -> Required.required_unless(Enum.at(rule, 1), all_data , value)
      action == "required_with" -> Required.required_with(Enum.at(rule, 1), all_data , value)
      action == "required_without" -> Required.required_without(Enum.at(rule, 1), all_data , value)
      action == "nullable" -> Nullable.is_null?(value)
      action == "string" -> Alpha.is_string(value)
      action == "alpha" -> Alpha.is_alpha(value)
      action == "accepted" -> Accepted.is_accepted(value)
      action == "boolean" -> Boolean.validate_boolean(value)
      action == "numeric" -> Numbers.validation_numeric(value)
      action == "email" -> Internet.email(value)
      action == "url" -> Internet.url(value)
      action == "ip" -> Internet.ip(value)
      action == "ipv4" -> Internet.ipv4(value)
      action == "ipv6" -> Internet.ipv6(value)
      action == "uuid" -> Uuid.is_uuid(value)
      action == "date" -> DateTime.is_date(value)
      action == "time" -> DateTime.is_time(value)
      action == "datetime" -> DateTime.is_date_time(value)
      action == "timezone" -> DateTime.is_timezone(value)
      #      Validates
      action == "start_with" -> Alpha.start_with(value, Enum.at(rule, 1))
      action == "end_with" -> Alpha.end_with(value, Enum.at(rule, 1))
      action == "digits" -> Numbers.digits(value, Enum.at(rule, 1))
      action == "max" -> Max.is_maximum(value, Enum.at(rule, 1))
      action == "min" -> Min.is_minimum(value, Enum.at(rule, 1))
      action == "in" -> In.is_in(value, Enum.at(rule, 1))
      action == "not_in" -> In.is_not_in(value, Enum.at(rule, 1))
      action == "date_equals" -> DateTime.date_equals(value, Enum.at(rule, 1))
      action == "after" -> DateTime.is_after(value, Enum.at(rule, 1))
      action == "after_or_equal" -> DateTime.is_after_or_equal(value, Enum.at(rule, 1))
      action == "before" -> DateTime.is_before(value, Enum.at(rule, 1))
      action == "before_or_equal" -> DateTime.is_before_or_equal(value, Enum.at(rule, 1))
      action == "different" -> Different.is_different(value, Enum.at(rule, 1))
      action == "equal" -> Different.equal(value, Enum.at(rule, 1))
      action == "gt" -> Different.gt(value, Enum.at(rule, 1))
      action == "gte" -> Different.gte(value, Enum.at(rule, 1))
      action == "lt" -> Different.lt(value, Enum.at(rule, 1))
      action == "lte" -> Different.lte(value, Enum.at(rule, 1))
      #      Fields
      action == "confirmed" ->
        confirmed_name = "#{rule_field}_confirmation"
        if Field.field_exist?(confirmed_name, all_data) do
          check_point = Map.fetch!(all_data, String.to_atom(confirmed_name))
          Confirmation.is_confirmed(value, check_point)
        else
          false
        end
      action == "nullable" -> Nullable.is_null?(value)
      true -> false
    end
  end

end
