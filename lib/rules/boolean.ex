defmodule ElxValidation.Boolean do
  def is_boolean(target) do
    cond do
      target == true -> true
      target == false -> true
      target == 1 -> true
      target == 0 -> true
      true -> false
    end
  end
end
