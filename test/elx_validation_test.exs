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

  # Accepted
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

  #  alpha test
  test "alpha passed" do
    data = %{
      name: "John Doe"
    }
    rules = [
      %{
        field: "name",
        validate: ["alpha"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "alpha filed" do
    data = %{
      name: "John 007"
    }
    rules = [
      %{
        field: "name",
        validate: ["alpha"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               name: ["The name may only contain letters."]
             ],
             failed: true
           }
  end

  #  String test
  test "string passed" do
    data = %{
      user_name: "John_007"
    }
    rules = [
      %{
        field: "user_name",
        validate: ["string"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "sting filed" do
    data = %{
      user_name: 123
    }
    rules = [
      %{
        field: "user_name",
        as: "user name",
        validate: ["string"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               user_name: ["The user name may only string."]
             ],
             failed: true
           }
  end
end
