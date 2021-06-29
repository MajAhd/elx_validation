defmodule ElxValidation.En do
  @moduledoc """
    Message builder
  - not use inside validator
  - called automatically by validator
  """
  @doc """
     call message based on rule name and parameters
  """
  def message(attribute, value) do
    [
      field: "The #{attribute} is not exist",
      required: "The #{attribute} field is required.",
      required_if: "The #{attribute} field is required when #{value} is exist.",
      required_unless: "The #{attribute} field is required unless #{value} is not exist or empty.",
      required_with: 'The #{attribute} field is required when #{value} is present.',
      required_without: 'The #{attribute} field is required when #{value} is not present.',
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
      date: "The #{attribute} is not a valid date.",
      time: "The #{attribute} is not a valid time.",
      datetime: "The #{attribute} is not a valid datetime.",
      timezone: "The #{attribute} is not a valid Timezone.",
      date_equals: "The #{attribute} must be a date equal to #{value}.",
      date_equals: "The #{attribute} must be a date Equal to #{value}.",
      after: "The #{attribute} must be a date after to #{value}.",
      after_or_equal: "The #{attribute} must be a date after or equal to #{value}.",
      before: "The #{attribute} must be a date before to #{value}.",
      before_or_equal: "The #{attribute} must be a date before or equal to #{value}.",
      different: "The #{attribute} must be different to #{value}.",
      equal: "The #{attribute} must be equal to #{value}.",
      gt: "The #{attribute} must be greater than #{value}.",
      gte: "The #{attribute} must be greater or equal to #{value}.",
      lt: "The #{attribute} must be less than #{value}.",
      lte: "The #{attribute} must be less or equal to #{value}.",
      confirmed: "The #{attribute} confirmation does not match.",
      nullable: "The #{attribute} can be a null.",
    ]
  end

end
