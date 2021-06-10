defmodule ElxValidationTest do
  use ExUnit.Case
  doctest ElxValidation
  # Field Test
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

  #  Required test
  test "required passed" do
    data = %{
      name: "Majid ahd",
      email: "example@email.com"
    }
    rules = [
      %{
        field: "name",
        as: "first name",
        validate: ["required", "min:4", "max:10"]
      },
      %{
        field: "email",
        validate: ["required", "email"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "required failed" do
    data = %{
      user_name: "",
      name: "Majid Ahmadi",
      email: "example@email.com"
    }
    rules = [
      %{
        field: "user_name",
        as: "user name",
        validate: ["required", "alpha", "max:30"]
      },
      %{
        field: "name",
        as: "first name",
        validate: ["required", "min:4", "max:10"]
      },
      %{
        field: "email",
        validate: ["required", "email"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               user_name: ["The user name field is required.", "The user name may only contain letters."],
               name: ["The first name may not be greater than 10."]
             ],
             failed: true
           }
  end
end
