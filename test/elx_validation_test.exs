defmodule ElxValidationTest do
  use ExUnit.Case
  doctest ElxValidation

  test "field passed" do
    data = %{
      name: "Majid"
    }
    rules = [
      %{
        field: "name",
        validate: ["alpha"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end

  test "field failed" do
    data = %{
      first_name: "Majid"
    }
    rules = [
      %{
        field: "name",
        validate: ["alpha"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               name: ["The name is not exist"]
             ],
             failed: true
           }
  end

  test "required passed" do
    data = %{
      name: "Majid"
    }
    rules = [
      %{
        field: "name",
        as: "first name",
        validate: ["required"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end

  test "required failed" do
    data = %{
      name: ""
    }
    rules = [
      %{
        field: "name",
        as: "first name",
        validate: ["required"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               name: ["The first name field is required."]
             ],
             failed: true
           }
  end
end
