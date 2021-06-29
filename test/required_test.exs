defmodule ElxValidation.RequiredTest do
  use ExUnit.Case
  doctest ElxValidation.Required

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
  #  Required id tes
  test "required_if passed" do
    data = %{
      first_name: "john",
      last_name: "doe"
    }
    rules = [
      %{
        field: "first_name",
        validate: ["nullable", "alpha", "min:3", "max:10"]
      },
      %{
        field: "last_name",
        validate: ["required_if:first_name", "alpha", "min:3", "max:10"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "required_if failed" do
    data = %{
      first_name: "john",
      last_name: ""
    }
    rules = [
      %{
        field: "first_name",
        validate: ["nullable", "alpha", "min:3", "max:10"]
      },
      %{
        field: "last_name",
        validate: ["required_if:first_name"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               last_name: ["The last_name field is required when first_name is exist."]
             ],
             failed: true
           }
  end
end