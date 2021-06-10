defmodule AcceptedTest do
  use ExUnit.Case
  doctest ElxValidation.Accepted
   test "is_accepted" do
     assert ElxValidation.Accepted.is_accepted("true") == true
     assert ElxValidation.Accepted.is_accepted(true) == true
     assert ElxValidation.Accepted.is_accepted("yes") == true
     assert ElxValidation.Accepted.is_accepted("on") == true
     assert ElxValidation.Accepted.is_accepted("1") == true
     assert ElxValidation.Accepted.is_accepted(1) == true
     assert ElxValidation.Accepted.is_accepted(0) == false
     assert ElxValidation.Accepted.is_accepted(false) == false
     assert ElxValidation.Accepted.is_accepted("false") == false
     assert ElxValidation.Accepted.is_accepted("no") == false
  end

  # Accepted Test
  test "accepted passed" do
    data = %{
      agreement1: "on",
      agreement2: true,
      agreement3: "true",
      agreement4: "yes",
      agreement5: "1",
      agreement6: 1,
    }
    rules = [
      %{
        field: "agreement1",
        validate: ["required", "accepted"]
      },
      %{
        field: "agreement2",
        validate: ["accepted"]
      },
      %{
        field: "agreement3",
        validate: ["accepted"]
      },
      %{
        field: "agreement4",
        validate: ["accepted"]
      },
      %{
        field: "agreement5",
        validate: ["accepted"]
      },
      %{
        field: "agreement6",
        validate: ["accepted"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "accepted failed" do
    data = %{
      user_agreement: "false"
    }
    rules = [
      %{
        field: "user_agreement",
        as: "user agreement",
        validate: ["accepted"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               user_agreement: ["The user agreement must be accepted."]
             ],
             failed: true
           }
  end

end
