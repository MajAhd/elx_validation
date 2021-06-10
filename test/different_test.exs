defmodule ElxValidation.DifferentTest do
  use ExUnit.Case
  doctest ElxValidation.Different

  test "is_different" do
    assert  ElxValidation.Different.is_different("john", "james") == true
    assert  ElxValidation.Different.is_different(10, "20") == true
    assert  ElxValidation.Different.is_different("john", "john") == false
    assert  ElxValidation.Different.is_different(nil, nil) == false
    assert  ElxValidation.Different.is_different("", "") == false
  end
  test "equal" do
    assert  ElxValidation.Different.equal("john", "john") == true
    assert  ElxValidation.Different.equal(10, "10") == true
    assert  ElxValidation.Different.equal("john", "james") == false
    assert  ElxValidation.Different.equal(nil, nil) == false
    assert  ElxValidation.Different.equal("", "") == true
  end

  test "gt" do
    assert  ElxValidation.Different.gt("john1", "john") == true
    assert  ElxValidation.Different.gt(11, "10") == true
    assert  ElxValidation.Different.gt("john", "john") == false
    assert  ElxValidation.Different.gt("joe", "joe") == false
    assert  ElxValidation.Different.gt(nil, nil) == false
    assert  ElxValidation.Different.gt("", "") == false
  end
  test "gte" do
    assert  ElxValidation.Different.gte("john1", "john") == true
    assert  ElxValidation.Different.gte("john", "john") == true
    assert  ElxValidation.Different.gte(11, "10") == true
    assert  ElxValidation.Different.gte(11, "11") == true
    assert  ElxValidation.Different.gte("john", "john") == true
    assert  ElxValidation.Different.gte("joe", "john") == false
    assert  ElxValidation.Different.gte(nil, nil) == false
    assert  ElxValidation.Different.gte("", "") == true
  end

  test "lt" do
    assert  ElxValidation.Different.lt("john", "john1") == true
    assert  ElxValidation.Different.lt(10, "11") == true
    assert  ElxValidation.Different.lt("john", "john") == false
    assert  ElxValidation.Different.lt("john", "joe") == false
    assert  ElxValidation.Different.lt(nil, nil) == false
    assert  ElxValidation.Different.lt("", "") == false
  end

  test "lte" do
    assert  ElxValidation.Different.lte("joe", "john") == true
    assert  ElxValidation.Different.lte("john", "john") == true
    assert  ElxValidation.Different.lte(10, "11") == true
    assert  ElxValidation.Different.lte(11, "11") == true
    assert  ElxValidation.Different.lte("john", "joe") == false
    assert  ElxValidation.Different.lte(nil, nil) == false
    assert  ElxValidation.Different.lte("", "") == true
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
end