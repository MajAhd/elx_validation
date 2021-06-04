defmodule ElxValidation.Boolean do
  @moduledoc """
     Run Check Boolean data
  """
  @doc """
    Boolean data : true , false , 1, 0
  """

  def is_boolean(target) do
    cond do
      target == true -> true
      target == false -> true
      target == 1 -> true
      target == 0 -> true
      true -> false
    end
  end
end
