alias ElxValidation.{Required, Nullable, Alpha, Accepted, Boolean, Max, Min}
defmodule ElxValidation.BindRules do

  def build(action, values) do
    cond do
      action == "required" -> Required.is_require?(values)
      action == "nullable" -> Nullable.is_null?(values)
      action == "string" -> Alpha.is_string(values)
      action == "alpha" -> Alpha.is_alpha(values)
      action == "accepted" -> Accepted.is_accepted(values)
      action == "boolean" -> Boolean.is_boolean(values)
      action == "max" -> Max.is_maximum(Enum.at(values, 0), Enum.at(values, 1))
      action == "min" -> Min.is_minimum(Enum.at(values, 0), Enum.at(values, 1))
      true -> false
    end

  end
end
