defmodule ElxValidation.Alpha do
  @moduledoc """
  ### string

  - The field under validation must be a string. If you would like to allow the field to also be null, you should assign
  the nullable rule to the field.
  ```
  data = %{
     user_name1: "john_007",
     user_name2: 1879,   ---> return error
  }
  rules = [
      %{
        field: "user_name1",
        validate: ["string"]
      },
     %{
        field: "user_name2",
        validate: ["string"]
      }
    ]
  ```

  ***

  ### alpha

  - The field under validation must be entirely alphabetic characters.
  ```
  data = %{
     p1: "John Doe",
     p1: "James 007",   ---> return error
  }
  rules = [
      %{
        field: "p1",
        validate: ["alpha"]
      },
     %{
        field: "p2",
        validate: ["alpha"]
      }
    ]
  ```
  ***
  ### start_with:foo
  - The field under validation must start with the given values.

  ```
  data = %{
      start_code: "G123other_string",
      start_code2: "other_string". ---> return error
    }
  rules = [
      %{
        field: "start_code",
        validate: ["start_with:G123"]
      },
      %{
        field: "start_code2",
        validate: ["start_with:Me32"]
      }
  ]
  ```

  ### end_with:foo

  - The field under validation must end with the given values
  ```
  data = %{
      end_code: "other_stringG123",
      end_code2: "other_string". ---> return error
    }
  rules = [
      %{
        field: "end_code",
        validate: ["end_with:G123"]
      },
      %{
        field: "end_code2",
        validate: ["end_with:Me32"]
      }
  ]
  ```
  """
  @doc """
    Validate String data
  """
  def is_string(target) do
    is_bitstring(target)
  rescue
    _ ->
      false

  end
  @doc """
    Validate Only Alpha data [a to z / A to Z]
  """
  def is_alpha(target) do

    Regex.match?(~r/^[A-Za-z]+$/, String.replace(target, " ", ""))
  rescue
    _ ->
      false

  end
  @doc """
    Validate String starter value :
    target : "code1234" check:code -> passed
  """
  def start_with(target, start_value) do

    cond do
      !is_string(target) -> false
      String.length(target) < String.length(start_value) -> false
      String.slice(target, 0..String.length(start_value) - 1) == start_value -> true
      true -> false
    end
  rescue
    _ ->
      false

  end
  @doc """
    Validate String end value :
    target : "1234code" check:code -> passed
  """
  def end_with(target, end_value) do
    cond do
      !is_string(target) -> false
      String.length(target) < String.length(end_value) -> false
      String.slice(target, String.length(end_value) * -1..-1) == end_value -> true
      true -> false
    end
  rescue
    _ ->
      false
  end
end
