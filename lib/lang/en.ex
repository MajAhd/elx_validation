defmodule ElxValidation.En do
  alias ElxValidation.En
  def message(attribute, validate \\ []) do
    [
      field: "The #{attribute} is not exist",
      required: "The #{attribute} field is required.",
      alpha: "The #{attribute} may only contain letters.",
      string: "The #{attribute} may only string.",
      accepted: "The #{attribute} must be accepted.",
      max: "The #{attribute} may not be greater than #{validate[:max]}.",
      min: "The #{attribute} must be at least #{validate[:min]}.",
    ]
  end
end
