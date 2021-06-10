defmodule ElxValidation.Different do
  @moduledoc """
  ### different:value
  - The field under validation must have a different value than field.
  ### equal:value
  - The field under validation must be equal to the given field. The two fields must be of the same type.
  Strings and numerics are evaluated using the same conventions as the size rule.
  ### gt:value
  - The field under validation must be greater than the given field. The two fields must be of the same type. Strings and numerics are evaluated using the same conventions as the size rule.
  ### gte:value
  - The field under validation must be greater than or equal to the given field. The two fields must be of the same type.
  Strings and numerics are evaluated using the same conventions as the size rule.
  ### lt:value
  - The field under validation must be less than the given field. The two fields must be of the same type. Strings and numerics are evaluated using the same conventions as the size rule.
  ### lte:value
  - The field under validation must be less than or equal to the given field. The two fields must be of the same type.
  Strings and numerics are evaluated using the same conventions as the size rule.
  ### examples
  ```
  data = %{
     num_diff: 234 --> not be 233
     str_diff: "MQZVD --> not be "ABCD"
  }

  rules = [
      %{
        field: "num_diff",
        validate: ["different:233"]
      },
      %{
        field: "str_diff",
        validate: ["different:ABCD"]
      }
  ]
  ```
  ***

  ```
  data = %{
     num_eq: 100,  --> must be 100
     str_eq: "abcd" --> must be "abcd"
  }

  rules = [
      %{
        field: "num_eq",
        validate: ["equal:100"]
      },
      %{
        field: "str_eq",
        validate: ["equal:abcd"]
      },
  ]
  ```
  ***
  ```
  data = %{
     num_gt: 101,  --> greater than 100
     num_gte: 200,   --> greater than or equal 200
     str_gt: "abcd",  --> length of this must greater than length of abc(3 char)
     str_gte: "abcd" --> length of this must greater than or equal length of abc(3 char)
  }

  rules = [
     %{
        field: "num_gt",
        validate: ["gt:100"]
      },
      %{
        field: "num_gte",
        validate: ["gte:200"]
      },
      %{
        field: "str_gt",
        validate: ["gt:abc"]
      },
      %{
        field: "str_gte",
        validate: ["gte:abc"]
      },
  ]
  ```
  ***
  ```
  data = %{
   num_lt: 99, --> less than 100
   num_lte: 199, --> less than or equal 200
   str_lt: "ab",  --> length of this must less than length of abc(3char)
   str_lte: "abcd" --> length of this must less than length of abcde(5 char)
  }

  rules = [
     %{
        field: "num_lt",
        validate: ["lt:100"]
      },
      %{
        field: "num_lte",
        validate: ["lte:200"]
      },
      %{
        field: "str_lt",
        validate: ["lt:ABC"]
      },
      %{
        field: "str_lte",
        validate: ["lte:ABCDE"]
      },
  ]
  ```
  """
  @doc """
    target has to different with value
  """
  def is_different(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) != target
      is_bitstring(target) -> value != target
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to equal to value
  """
  def equal(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) == target
      is_bitstring(target) -> value == target
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to greater than value
  """
  def gt(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) < target
      is_bitstring(target) -> String.length(value) < String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to equal or greater than value
  """
  def gte(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) <= target
      is_bitstring(target) -> String.length(value) <= String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to less than value
  """
  def lt(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) > target
      is_bitstring(target) -> String.length(value) > String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end
  @doc """
    target has to equal or less than value
  """
  def lte(target, value) do
    cond do
      is_number(target) -> String.to_integer(value) >= target
      is_bitstring(target) -> String.length(value) >= String.length(target)
      true -> false
    end
  rescue
    _ ->
      false
  end

end
