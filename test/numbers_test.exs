defmodule ElxValidation.NumbersTest do
  use ExUnit.Case
  doctest ElxValidation.Numbers

  test "validation_numeric" do
    assert ElxValidation.Numbers.validation_numeric(343) == true
    assert ElxValidation.Numbers.validation_numeric(3_434_354_656_743_323_245_456_767) == true
    assert ElxValidation.Numbers.validation_numeric("343") == false
    assert ElxValidation.Numbers.validation_numeric(nil) == false
  end

  test "digits" do
    assert ElxValidation.Numbers.digits(546, "3") == true
    assert ElxValidation.Numbers.digits(757_674_534_973_980_036_233_434, "24") == true
    assert ElxValidation.Numbers.digits(757_674_534_973_980_036_233_434, "3") == false
    assert ElxValidation.Numbers.digits("123", "3") == false
    assert ElxValidation.Numbers.digits("123", nil) == false
    assert ElxValidation.Numbers.digits(nil, nil) == false
    assert ElxValidation.Numbers.digits(nil, "3") == false
  end

  #  Numbers Test
  test "number passed" do
    data = %{
      check_number: 2121
    }

    rules = [
      %{
        field: "check_number",
        validate: ["numeric"]
      }
    ]

    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end

  test "number failed" do
    data = %{
      check_number: "2121"
    }

    rules = [
      %{
        field: "check_number",
        validate: ["numeric"]
      }
    ]

    assert ElxValidation.make(data, rules) == %{
             errors: [
               check_number: ["The check_number must be a number."]
             ],
             failed: true
           }
  end

  #  Digits test
  test "digits passed" do
    data = %{
      age: 12,
      year: 2020
    }

    rules = [
      %{
        field: "age",
        validate: ["digits:2"]
      },
      %{
        field: "year",
        validate: ["digits:4"]
      }
    ]

    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end

  test "digits failed" do
    data = %{
      age: 9
    }

    rules = [
      %{
        field: "age",
        validate: ["digits:2"]
      }
    ]

    assert ElxValidation.make(data, rules) == %{
             errors: [
               age: ["The age must be 2 digits."]
             ],
             failed: true
           }
  end
end
