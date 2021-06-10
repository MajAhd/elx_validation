defmodule ElxValidation.Boolean do
  @moduledoc """
  ### boolean
  - The field under validation must be able to be cast as a boolean. Accepted input are true, false, 1, 0, "1", and "0".
  ```
  data = %{
      is_ok1: "true",
      is_ok2: true,
      is_ok3: "false",
      is_ok4: false,
      is_ok5: 0,
      is_ok6: 1,
      is_ok7: "0",
      is_ok8: "1",
      is_ok9: "yes",  ---> return error
    }
  rules = [
      %{
        field: "is_ok1",
        validate: ["boolean"]
      },
      %{
        field: "is_ok2",
        validate: ["boolean"]
      },
      %{
        field: "is_ok3",
        validate: ["boolean"]
      },
      %{
        field: "is_ok4",
        validate: ["boolean"]
      },
      %{
        field: "is_ok5",
        validate: ["boolean"]
      },
      %{
        field: "is_ok6",
        validate: ["boolean"]
      },
      %{
        field: "is_ok7",
        validate: ["boolean"]
      },
      %{
        field: "is_ok8",
        validate: ["boolean"]
      },
     %{
        field: "is_ok9",
        validate: ["boolean"]
      },
    ]
  ```
  """
  @doc """
    Boolean data : true , "true" , false ,"false" , 1 , "1" , 0 or "0"
  """

  def validate_boolean(target) do
    cond do
      is_boolean(target) -> true
      target == "true" -> true
      target == "false" -> true
      target == 1 || target == "1" -> true
      target == 0 || target == "0" -> true
      true -> false
    end
  rescue
    _ ->
      false
  end
end
