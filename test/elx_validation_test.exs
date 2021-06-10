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



  #   test confirmation
  test "confirmed passed" do
    data = %{
      password: "123456",
      password_confirmation: "123456",
    }
    rules = [
      %{
        field: "password",
        validate: ["confirmed"]
      },

    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "confirmed failed" do
    data = %{
      password: "123456",
      password_confirmation2: "123456",
    }
    rules = [
      %{
        field: "password",
        validate: ["confirmed"]
      },

    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               password: ["The password confirmation does not match."]
             ],
             failed: true
           }
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
