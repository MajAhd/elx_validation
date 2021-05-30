defmodule ElxValidation.Max do
  #  Max on Numeric
  def max_number?(max, value) when max >= value do
    true
  end
  def max_number?(max, value) when max < value do
    false
  end

end
