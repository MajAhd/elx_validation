defmodule ElxValidation.Accepted do
  @moduledoc """
     Run Check Accepted data
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
