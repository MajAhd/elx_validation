defmodule ElxValidation.ConfirmationTest do
  use ExUnit.Case
  doctest ElxValidation.Confirmation
  test "is_confirmed" do
    assert  ElxValidation.Confirmation.is_confirmed("john", "john") == true
    assert  ElxValidation.Confirmation.is_confirmed("john", "john_123") == false
    assert  ElxValidation.Confirmation.is_confirmed(nil, nil) == true
    assert  ElxValidation.Confirmation.is_confirmed("", "") == true
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
end