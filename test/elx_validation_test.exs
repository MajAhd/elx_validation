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

  #  Different Values
  test "different passed" do
    data = %{
      num_diff: 234,
      str_diff: "MQ234",
      num_eq: 100,
      str_eq: "MQ100",
      num_gt: 101,
      num_gte: 200,
      str_gt: "MAQ200",
      str_gte: "MQ200",
      num_lt: 99,
      num_lte: 199,
      str_lt: "abc",
      str_lte: "abcd",
    }
    rules = [
      %{
        field: "num_diff",
        validate: ["different:233"]
      },
      %{
        field: "str_diff",
        validate: ["different:MQ233"]
      },

      %{
        field: "num_eq",
        validate: ["equal:100"]
      },
      %{
        field: "str_eq",
        validate: ["equal:MQ100"]
      },
      %{
        field: "num_gt",
        validate: ["gt:100"]
      },
      %{
        field: "num_gte",
        validate: ["gte:200"]
      },
      %{
        field: "str_gt",
        validate: ["gt:MQ200"]
      },
      %{
        field: "str_gte",
        validate: ["gte:MQ200"]
      },
      %{
        field: "num_lt",
        validate: ["lt:100"]
      },
      %{
        field: "num_lte",
        validate: ["lte:200"]
      },
      %{
        field: "str_lt",
        validate: ["lt:ABCD"]
      },
      %{
        field: "str_lte",
        validate: ["lte:ABCD"]
      },
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "different failed" do
    data = %{
      num_diff: 233,
      str_diff: "MQ233",
      num_eq: 200,
      str_eq: "MQ200",
      num_gt: 100,
      num_gte: 199,
      str_gt: "MQ200",
      str_gte: "MQ200",
      num_lt: 100,
      num_lte: 201,
      str_lt: "abcdef",
      str_lte: "abcde",
    }
    rules = [
      %{
        field: "num_diff",
        validate: ["different:233"]
      },
      %{
        field: "str_diff",
        validate: ["different:MQ233"]
      },
      %{
        field: "num_eq",
        validate: ["equal:100"]
      },
      %{
        field: "str_eq",
        validate: ["equal:MQ100"]
      },
      %{
        field: "num_gt",
        validate: ["gt:100"]
      },
      %{
        field: "num_gte",
        validate: ["gte:200"]
      },
      %{
        field: "str_gt",
        validate: ["gt:MQ2000"]
      },
      %{
        field: "str_gte",
        validate: ["gte:MQ2000"]
      },
      %{
        field: "num_lt",
        validate: ["lt:100"]
      },
      %{
        field: "num_lte",
        validate: ["lte:200"]
      },
      %{
        field: "str_lt",
        validate: ["lt:abcde"]
      },
      %{
        field: "str_lte",
        validate: ["lte:abcd"]
      },
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               num_diff: ["The num_diff must be different to 233."],
               str_diff: ["The str_diff must be different to MQ233."],
               num_eq: ["The num_eq must be equal to 100."],
               str_eq: ["The str_eq must be equal to MQ100."],
               num_gt: ["The num_gt must be greater than 100."],
               num_gte: ["The num_gte must be greater or equal to 200."],
               str_gt: ["The str_gt must be greater than MQ2000."],
               str_gte: ["The str_gte must be greater or equal to MQ2000."],
               num_lt: ["The num_lt must be less than 100."],
               num_lte: ["The num_lte must be less or equal to 200."],
               str_lt: ["The str_lt must be less than abcde."],
               str_lte: ["The str_lte must be less or equal to abcd."]
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
