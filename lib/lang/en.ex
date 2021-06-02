defmodule ElxValidation.En do
  alias ElxValidation.En
  def message(attribute, validate \\ []) do
    [
      field: "The #{attribute} is not exist",
      required: "The #{attribute} field is required.",
      accepted: "The #{attribute} must be accepted.",
      alpha: "The #{attribute} may only contain letters.",
      max: "The #{attribute} may not be greater than #{validate[:max]}.",
      min: "The #{attribute} must be at least #{validate[:min]}.",
    ]
  end
end
