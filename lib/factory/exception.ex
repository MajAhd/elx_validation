defmodule ElxValidation.Exception do
  alias ElxValidation.En
  def lang(lang_name) do
    lang_name
  end
  def build_exception(field) do
    errors = %{}
    Map.put(errors, String.to_atom(field), [])
  end

  def push_error?(errors, field, type, as \\ nil) when as == nil do
    message = En.message(field)
    errors = Map.put(errors, String.to_atom(field), errors[String.to_atom(field)] ++ [message[String.to_atom(type)]])
    errors
  end

  def push_error?(errors, field, type, as) when as != nil do
    message = En.message(as)
    errors = Map.put(errors, String.to_atom(field), errors[String.to_atom(field)] ++ [message[String.to_atom(type)]])
    errors
  end
end
