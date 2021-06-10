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

  #  Boolean test
  test "boolean passed" do
    data = %{
      is_ok1: "true",
      is_ok2: true,
      is_ok3: "false",
      is_ok4: false,
      is_ok5: 0,
      is_ok6: 1,
      is_ok7: "0",
      is_ok8: "1",
    }
    rules = [
      %{
        field: "is_ok1",
        validate: ["boolean"]
      },
      %{
        field: "is_ok2",
        validate: ["boolean"]
      },
      %{
        field: "is_ok3",
        validate: ["boolean"]
      },
      %{
        field: "is_ok4",
        validate: ["boolean"]
      },
      %{
        field: "is_ok5",
        validate: ["boolean"]
      },
      %{
        field: "is_ok6",
        validate: ["boolean"]
      },
      %{
        field: "is_ok7",
        validate: ["boolean"]
      },
      %{
        field: "is_ok8",
        validate: ["boolean"]
      },
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "boolean failed" do
    data = %{
      is_ok: "yes"
    }
    rules = [
      %{
        field: "is_ok",
        validate: ["boolean"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               is_ok: ["The is_ok may only boolean value : true , false , 1 or 0."]
             ],
             failed: true
           }
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
      age: 12
    }
    rules = [
      %{
        field: "age",
        validate: ["digits:2"]
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
  # test Min
  test "min passed" do
    data = %{
      name: "john doe",
      age: 20
    }
    rules = [
      %{
        field: "name",
        validate: ["min:5"]
      },
      %{
        field: "age",
        validate: ["min:20"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}

  end
  test "min failed" do
    data = %{
      name: "john",
      age: 19
    }
    rules = [
      %{
        field: "name",
        validate: ["min:5"]
      },
      %{
        field: "age",
        validate: ["min:20"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               name: ["The name must be at least 5."],
               age: ["The age must be at least 20."]
             ],
             failed: true
           }
  end
  #  test internet addresses
  test "internet passed" do
    data = %{
      email: "example@gmail.com",
      url: "http://google.com",
      ip: "192.168.1.1",
      ipv4: "192.168.1.1",
      ipv6: "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
    }
    rules = [
      %{
        field: "email",
        validate: ["email"]
      },
      %{
        field: "url",
        validate: ["url"]
      },
      %{
        field: "ip",
        validate: ["ip"]
      },
      %{
        field: "ipv4",
        validate: ["ipv4"]
      },
      %{
        field: "ipv6",
        validate: ["ipv6"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "internet failed" do
    data = %{
      email: "example.com",
      url: "http://google",
      ip: "192.168.1",
      ipv4: "192.168.1",
      ipv6: "2001:0db8:85a3:0000:0000:8a2e"
    }
    rules = [
      %{
        field: "email",
        validate: ["email"]
      },
      %{
        field: "url",
        validate: ["url"]
      },
      %{
        field: "ip",
        validate: ["ip"]
      },
      %{
        field: "ipv4",
        validate: ["ipv4"]
      },
      %{
        field: "ipv6",
        validate: ["ipv6"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               email: ["The email must be a valid email address."],
               url: ["The url  must be a valid URL address."],
               ip: ["The ip must be a valid IP address."],
               ipv4: ["The ipv4 must be a valid IPv4 address."],
               ipv6: ["The ipv6 must be a valid IPv6 address."]
             ],
             failed: true
           }
  end

  # test in / not in
  test "collection passed" do
    data = %{
      country: "italy",
      grade: "a",
    }
    rules = [
      %{
        field: "country",
        validate: ["in:iran,italy,usa"]
      },
      %{
        field: "grade",
        validate: ["not_in:c,d,e", "in:a,b"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "collection failed" do
    data = %{
      grade: "u",
    }
    rules = [
      %{
        field: "grade",
        validate: ["not_in:c,d,e", "in:a,b"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               grade: ["The selected grade is invalid."]
             ],
             failed: true
           }
  end
  #  test uuid
  test "uuid passed" do
    data = %{
      uuid_1: "56b2724e-9074-4dc3-9803-4bb13c92ee0e",
    }
    rules = [
      %{
        field: "uuid_1",
        validate: ["uuid"]
      },

    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "uuid failed" do
    data = %{
      uuid_1: "56b2-9074-4dc3-9803-4bb13c9",
    }
    rules = [
      %{
        field: "uuid_1",
        validate: ["uuid"]
      },

    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               uuid_1: ["The uuid_1 must be a valid UUID."]
             ],
             failed: true
           }
  end
  #  test Date Time
  test "date time passed" do
    data = %{
      birthdate: "1990-04-17",
      start_time: "13:30",
      expired: "2020-06-28 12:20",
      my_zone: "+04:30",
    }
    rules = [
      %{
        field: "birthdate",
        validate: ["date"]
      },
      %{
        field: "start_time",
        validate: ["time"]
      },
      %{
        field: "expired",
        validate: ["datetime"]
      },
      %{
        field: "my_zone",
        validate: ["timezone"]
      },
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "date time failed" do
    data = %{
      birthdate: "199004-17",
      start_time: "1330",
      expired: "2020-06-2812:20",
      my_zone: "04:30"
    }
    rules = [
      %{
        field: "birthdate",
        validate: ["date"]
      },
      %{
        field: "start_time",
        validate: ["time"]
      },
      %{
        field: "expired",
        validate: ["datetime"]
      },
      %{
        field: "my_zone",
        validate: ["timezone"]
      },
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               birthdate: ["The birthdate is not a valid date."],
               start_time: ["The start_time is not a valid time."],
               expired: ["The expired is not a valid datetime."],
               my_zone: ["The my_zone is not a valid Timezone."]
             ],
             failed: true
           }
  end

  test "date diff passed" do
    data = %{
      eq_bd: "1990-04-17",
      after_bd: "1990-04-20",
      after_equal_bd: "1990-04-18",
      before_bd: "1990-04-16",
      before_equal_bd: "1990-04-17",
    }
    rules = [
      %{
        field: "eq_bd",
        validate: ["date_equals:1990-04-17"]
      },
      %{
        field: "after_bd",
        validate: ["after:1990-04-17"]
      },
      %{
        field: "after_equal_bd",
        validate: ["after_or_equal:1990-04-17"]
      },
      %{
        field: "before_bd",
        validate: ["before:1990-04-17"]
      },
      %{
        field: "before_equal_bd",
        validate: ["before_or_equal:1990-04-17"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "date diff failed" do
    data = %{
      eq_bd: "1990-04-14",
      after_bd: "1990-04-16",
      after_equal_bd: "1990-04-15",
      before_bd: "1990-04-17",
      before_equal_bd: "1990-04-18",
    }
    rules = [
      %{
        field: "eq_bd",
        validate: ["date_equals:1990-04-17"]
      },
      %{
        field: "after_bd",
        validate: ["after:1990-04-17"]
      },
      %{
        field: "after_equal_bd",
        validate: ["after_or_equal:1990-04-17"]
      },
      %{
        field: "before_bd",
        validate: ["before:1990-04-17"]
      },
      %{
        field: "before_equal_bd",
        validate: ["before_or_equal:1990-04-17"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               eq_bd: ["The eq_bd must be a date equal to 1990-04-17."],
               after_bd: ["The after_bd must be a date after to 1990-04-17."],
               after_equal_bd: ["The after_equal_bd must be a date after or equal to 1990-04-17."],
               before_bd: ["The before_bd must be a date before to 1990-04-17."],
               before_equal_bd: ["The before_equal_bd must be a date before or equal to 1990-04-17."]
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
