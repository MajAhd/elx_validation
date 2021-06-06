defmodule ElxValidation.BindRules do
  alias ElxValidation.{Accepted, Alpha, Boolean, In, Internet, Max, Min, Nullable, Numbers}
  alias ElxValidation.{DateTime, Required, Uuid}
  @moduledoc """
   call rule functions
  """
  @doc """
     build rules by rule name
    action :  rules types
    values : data value for validation - single value
  """

  def build(action, value) do
    cond do
      action == "required" -> Required.is_require?(value)
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
      true -> false
    end
  end
  @doc """
  build rules by rule name
    action :  rules types
    values : data value for validation is multi value
  """
  def build_multiple(action, check_point, value) do
    cond do
      action == "start_with" -> Alpha.start_with(value, check_point)
      action == "end_with" -> Alpha.end_with(value, check_point)
      action == "digits" -> Numbers.digits(value, check_point)
      action == "max" -> Max.is_maximum(value, check_point)
      action == "min" -> Min.is_minimum(value, check_point)
      action == "in" -> In.is_in(value, check_point)
      action == "not_in" -> In.is_not_in(value, check_point)
      true -> false
    end
  end

end
