defmodule ElxValidation.BindRules do
  alias ElxValidation.{Accepted, Alpha, Boolean, Max, Min, Nullable, Required}
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
      action == "boolean" -> Boolean.is_boolean(value)
      true -> false
    end
  end
  @doc """
  build rules by rule name
    action :  rules types
    values : data value for validation is multi value
  """
  def build_multiple(action, check_point , value) do
    cond do
      action == "start_with" -> Alpha.start_with(value, check_point)
      action == "end_with" -> Alpha.end_with(value, check_point)
      action == "max" -> Max.is_maximum(value, check_point)
      action == "min" -> Min.is_minimum(value, check_point)
      true -> false
    end
  end

end
