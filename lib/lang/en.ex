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
      boolean: "The #{attribute} may only boolean value : true , false , 1 or 0.",
      string: "The #{attribute} may only string.",
      start_with: "The #{attribute} may only start with #{value}.",
      end_with: "The #{attribute} may only end with #{value}.",
      numeric: "The #{attribute} must be a number.",
      digits: "The #{attribute} must be #{value} digits.",
      max: "The #{attribute} may not be greater than #{value}.",
      min: "The #{attribute} must be at least #{value}.",
      email: "The #{attribute} must be a valid email address.",
      url: "The #{attribute}  must be a valid URL address.",
      ip: "The #{attribute} must be a valid IP address.",
      ipv4: "The #{attribute} must be a valid IPv4 address.",
      ipv6: "The #{attribute} must be a valid IPv6 address.",
      in: "The selected #{attribute} is invalid.",
      not_in: "The selected #{attribute} is invalid.",
      uuid: "The #{attribute} must be a valid UUID.",
    ]
  end

end
