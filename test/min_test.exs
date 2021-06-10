defmodule ElxValidation.MinTest do
  use ExUnit.Case
  doctest ElxValidation.Min
  test "is_minimum" do
    assert  ElxValidation.Min.is_minimum(10 ,"10") == true
    assert  ElxValidation.Min.is_minimum(11 ,"10") == true
    assert  ElxValidation.Min.is_minimum(9 ,"10") == false
    assert  ElxValidation.Min.is_minimum(nil, "10") == false
    assert  ElxValidation.Min.is_minimum(nil, nil) == false
    assert  ElxValidation.Min.is_minimum(10, nil) == false
    assert  ElxValidation.Min.is_minimum(10, 10) == false

  end
  # test Min
  test "min passed" do
    data = %{
      name: "john doe",
      age: 20
    }
    rules = [
      %{
        field: "name",
        validate: ["min:5"]
      },
      %{
        field: "age",
        validate: ["min:20"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}

  end
  test "min failed" do
    data = %{
      name: "john",
      age: 19
    }
    rules = [
      %{
        field: "name",
        validate: ["min:5"]
      },
      %{
        field: "age",
        validate: ["min:20"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               name: ["The name must be at least 5."],
               age: ["The age must be at least 20."]
             ],
             failed: true
           }
  end
end