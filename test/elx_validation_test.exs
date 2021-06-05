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
  test "string filed" do
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

  # start_with test
  test "string start with passed" do
    data = %{
      start_code: "G123other_string"
    }
    rules = [
      %{
        field: "start_code",
        validate: ["start_with:G123"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end

  test "string start with failed" do
    data = %{
      start_code: "string value"
    }
    rules = [
      %{
        field: "start_code",
        validate: ["start_with:G123"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               start_code: ["The start_code may only start with G123."]
             ],
             failed: true
           }
  end

  # end_with test
  test "string end with passed" do
    data = %{
      end_code: "other_stringG123"
    }
    rules = [
      %{
        field: "end_code",
        validate: ["end_with:G123"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "string end with failed" do
    data = %{
      end_code: "string value"
    }
    rules = [
      %{
        field: "end_code",
        validate: ["end_with:G123"]
      }
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               end_code: ["The end_code may only end with G123."]
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

end
