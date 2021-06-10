defmodule ElxValidation.Boolean do
  @moduledoc """
     Run Check Boolean data
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
