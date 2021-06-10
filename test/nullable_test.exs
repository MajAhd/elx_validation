defmodule ElxValidation.NullableTest do
  use ExUnit.Case
  doctest ElxValidation.Nullable
  test "is_null" do
    assert  ElxValidation.Nullable.is_null?("john") == true
    assert  ElxValidation.Nullable.is_null?("") == true
    assert  ElxValidation.Nullable.is_null?(nil) == true
  end

  #  Test Nullable
  test "nullable passed" do
    data = %{
      optional_name: "Majid",
    }
    rules = [
      %{
        field: "optional_name",

        validate: ["nullable", "alpha", "min:3"]
      },
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [],
             failed: false
           }
  end
end