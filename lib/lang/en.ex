defmodule ElxValidation.En do
  alias ElxValidation.En
  def message(attribute, validate \\ []) do
    [
      field: 'The #{attribute} is not exist',
      required: 'The #{attribute} field is required.',
      max: [
        numeric: 'The #{attribute} may not be greater than #{validate[:max]}.',
        string: 'The #{attribute} may not be greater than #{validate[:max]} characters.',
        file: 'The #{attribute}  may not be greater than #{validate[:max]} kilobytes.',
        array: 'The #{attribute}  may not be greater than #{validate[:max]} items.',
      ],
      min: [
        numeric: 'The #{attribute} must be at least #{validate[:min]}.',
        string: 'The #{attribute} must be at least #{validate[:min]} characters.',
        file: 'The #{attribute} must be at least #{validate[:min]} kilobytes.',
        array: 'The #{attribute} must be at least #{validate[:min]} items.',
      ]
    ]
  end
end
