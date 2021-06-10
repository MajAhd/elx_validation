defmodule ElxValidation.MaxTest do
  use ExUnit.Case
  doctest ElxValidation.Max

  test "is_minimum" do
    assert  ElxValidation.Max.is_maximum(9, "10") == true
    assert  ElxValidation.Max.is_maximum(10, "10") == true
    assert  ElxValidation.Max.is_maximum(11, "10") == false
    assert  ElxValidation.Max.is_maximum(nil, "10") == false
    assert  ElxValidation.Max.is_maximum(nil, nil) == false
    assert  ElxValidation.Max.is_maximum(10, nil) == false
    assert  ElxValidation.Max.is_maximum(10, 10) == false
  end

  # test Max
  test "max passed" do
    data = %{
      name: "john",
      age: 20
    }
    rules = [
      %{
        field: "name",
        validate: ["max:10"]
      },
      %{
        field: "age",
        validate: ["max:40"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}

  end
  test "max failed" do
    data = %{
      name: "john travolta",
      age: 54
    }
    rules = [
      %{
        field: "name",
        validate: ["max:10"]
      },
      %{
        field: "age",
        validate: ["max:40"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               name: ["The name may not be greater than 10."],
               age: ["The age may not be greater than 40."]
             ],
             failed: true
           }
  end

end