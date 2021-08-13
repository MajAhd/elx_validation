defmodule ElxValidation.Exception do
  alias ElxValidation.En

  @moduledoc """
   Control Exceptions and errors
  - not use inside validator
  - called automatically by validator
  """
  @doc """
    set error language
  """
  def lang(lang_name) do
    lang_name
  end

  @doc """
  create default error schema for each field
  """
  def build_exception(field) do
    errors = %{}
    Map.put(errors, String.to_atom(field), [])
  end

  @doc """
  create final error response
  """
  def response(errors, rule_field) do
    Enum.map(
      errors,
      fn error ->
        if error != nil do
          Enum.at(error[String.to_atom(rule_field)], 0)
        end
      end
    )
  end

  @doc """
     push error for each rule on value
     in case user defined `as` null or coustome name
  """
  def push_error?(errors, field, type, value, as) when as == nil do
    message = En.message(field, value)

    errors =
      Map.put(
        errors,
        String.to_atom(field),
        errors[String.to_atom(field)] ++ [message[String.to_atom(type)]]
      )

    errors
  end

  def push_error?(errors, field, type, value, as) when as !== nil do
    message = En.message(as, value)

    errors =
      Map.put(
        errors,
        String.to_atom(field),
        errors[String.to_atom(field)] ++ [message[String.to_atom(type)]]
      )

    errors
  end
end
