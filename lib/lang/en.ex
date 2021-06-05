defmodule ElxValidation.En do
  @moduledoc """
    Message builder
  """
  @doc """
     call message based on rule name and parameters
  """
  def message(attribute, value) do
    [
      field: "The #{attribute} is not exist",
      required: "The #{attribute} field is required.",
      accepted: "The #{attribute} must be accepted.",
      alpha: "The #{attribute} may only contain letters.",
      string: "The #{attribute} may only string.",
      start_with: "The #{attribute} may only start with #{value}.",
      end_with: "The #{attribute} may only end with #{value}.",
      max: "The #{attribute} may not be greater than #{value}.",
      min: "The #{attribute} must be at least #{value}.",
    ]
  end

end
