defmodule ElxValidation.Accepted do
  @moduledoc """
  - The field under validation must be "yes", "on", 1, or true. This is useful for validating "Terms of Service"
  acceptance or similar fields.
  ```
  data = %{
      agreement1: "on",
      agreement2: true,
      agreement3: "true",
      agreement4: "yes",
      agreement5: "1",
      agreement6: 1,
      agreement7: "off"
  }
  rules = [
      %{
        field: "agreement1",
        validate: ["required", "accepted"]
      },
      %{
        field: "agreement2",
        validate: ["accepted"]
      },
     %{
        field: "agreement3",
        validate: ["accepted"]
      },
      %{
        field: "agreement4",
        validate: ["accepted"]
      },
      %{
        field: "agreement5",
        validate: ["accepted"]
      },
      %{
        field: "agreement6",
        validate: ["accepted"]
      },
      %{
        field: "agreement7",
        validate: ["accepted"]
      }
    ]
  ElxValidation.make(data , rules)
  ```
  - agreement7 returned error because accepted validation must be one of the : true, "true", 1 , "1" , "on" , "yes"
  """
  @doc """
     Accepted Data included : yes , on , true ,1
     - Boolean : true , "true"
     - integer : 1 , "1"
     - string : "yes" , "on"
  """
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
  rescue
    _ ->
      false
  end
end
