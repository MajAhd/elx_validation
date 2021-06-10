defmodule ElxValidation.Confirmation do
  @moduledoc """
     Run Check Confirmation data
  """
  @doc """
    confirmation data:
    target :  password
    fields should contain :
        fields[:password]
        fields[:password_confirmation]
    and should equal
  """
  def is_confirmed(target, value) do
     target == value
  rescue
    _ ->
      false
  end
end
