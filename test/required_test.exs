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
  #  required unless
  test "required_unless passed" do
    data = %{
      email: "",
      phone: "+123456789",
    }
    rules = [
      %{
        field: "email",
        validate: ["nullable", "email"]
      },
      %{
        field: "phone",
        validate: ["required_unless:email"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "required_unless failed" do
    data = %{
      email: "email@example.com",
      phone: "+123456789",
    }
    rules = [
      %{
        field: "email",
        validate: ["nullable", "email"]
      },
      %{
        field: "phone",
        validate: ["required_unless:email"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               phone: ["The phone field is required unless email is not exist or empty."]
             ],
             failed: true
           }
  end

  #  Required with test
  test "required_with passed" do
    data = %{
      first_name: "john",
      last_name: "doe",
      full_name: "john doe"
    }
    rules = [
      %{
        field: "first_name",
        validate: ["nullable"]
      },
      %{
        field: "last_name",
        validate: ["nullable"]
      },
      %{
        field: "full_name",
        validate: ["required_with:first_name,last_name"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "required_with failed" do
    data = %{
      first_name: "",
      full_name: "john doe"
    }
    rules = [
      %{
        field: "first_name",
        validate: ["nullable"]
      },
      %{
        field: "full_name",
        validate: ["required_with:first_name,last_name"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               full_name: ["The full_name field is required when first_name,last_name is/are present."]
             ],
             failed: true
           }
  end

  #  Required without test
  test "required_without passed" do
    data = %{
      first_name: "",
      last_name: "",
      full_name: "john doe"
    }
    rules = [
      %{
        field: "first_name",
        validate: ["nullable"]
      },
      %{
        field: "last_name",
        validate: ["nullable"]
      },
      %{
        field: "full_name",
        validate: ["required_without:first_name,last_name"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "required_without failed" do
    data = %{
      first_name: "john",
      last_name: "doe",
      full_name: "john doe"
    }
    rules = [
      %{
        field: "first_name",
        validate: ["nullable"]
      },
      %{
        field: "last_name",
        validate: ["nullable"]
      },
      %{
        field: "full_name",
        validate: ["required_without:first_name,last_name"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               full_name: ["The full_name field is required when first_name,last_name is/are not present."]
             ],
             failed: true
           }
  end
end