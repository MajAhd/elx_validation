defmodule ElxValidation.Accepted do

  def is_accepted(target) do
    cond do
      target == true -> true
      target == "true" -> true
      target == "yes" -> true
      target == "on" -> true
      target == "1" -> true
      target == 1 -> true
      true -> false
    end
  end
end
