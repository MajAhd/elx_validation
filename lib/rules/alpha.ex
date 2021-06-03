defmodule ElxValidation.Alpha do

  def is_string(target) do
    is_bitstring(target)
  end
  def is_alpha(target) do
    Regex.match?(~r/^[A-Za-z]+$/, String.replace(target, " ", ""))
  end
  def starts_with() do  end
  def ends_with() do  end
end
