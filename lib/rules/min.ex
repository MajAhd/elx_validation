defmodule ElxValidation.Min do
  #  Min on Numeric
  def min_number?(min, value) when min <= value do
    true
  end
  def min_number?(min, value) when min > value do
    false
  end

end
