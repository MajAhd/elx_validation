defmodule ElxValidation.DateTime_test do
  use ExUnit.Case
  doctest ElxValidation.DateTime

  test "is_date" do
    assert  ElxValidation.DateTime.is_date("1990-04-17") == true
    assert  ElxValidation.DateTime.is_date("1990/04/17") == false
    assert  ElxValidation.DateTime.is_date("19900417") == false
    assert  ElxValidation.DateTime.is_date("") == false
    assert  ElxValidation.DateTime.is_date(nil) == false
  end
  test "is_time" do
    assert  ElxValidation.DateTime.is_time("14:20") == true
    assert  ElxValidation.DateTime.is_time("01:20am") == true
    assert  ElxValidation.DateTime.is_time("0120") == false
    assert  ElxValidation.DateTime.is_time(1230) == false
    assert  ElxValidation.DateTime.is_time("") == false
    assert  ElxValidation.DateTime.is_time(nil) == false
  end
  test "is_date_time" do
    assert  ElxValidation.DateTime.is_date_time("1990-04-17 14:20") == true
    assert  ElxValidation.DateTime.is_date_time("1990-04-1714:20") == false
    assert  ElxValidation.DateTime.is_date_time("1990-04-17 14:20am") == false
    assert  ElxValidation.DateTime.is_date_time(1990) == false
    assert  ElxValidation.DateTime.is_date_time("") == false
    assert  ElxValidation.DateTime.is_date_time(nil) == false
  end
  test "is_timezone" do
    assert  ElxValidation.DateTime.is_timezone("+04:30") == true
    assert  ElxValidation.DateTime.is_timezone("-01:00") == true
    assert  ElxValidation.DateTime.is_timezone("04:30") == false
    assert  ElxValidation.DateTime.is_timezone("0430") == false
    assert  ElxValidation.DateTime.is_timezone("") == false
    assert  ElxValidation.DateTime.is_timezone(nil) == false
    assert  ElxValidation.DateTime.is_timezone(430) == false
  end
  test "date_equals" do
    assert  ElxValidation.DateTime.date_equals("1990-04-17", "1990-04-17") == true
    assert  ElxValidation.DateTime.date_equals("1990-04-17", "1990-04-16") == false
    assert  ElxValidation.DateTime.date_equals(nil, "1990-04-16") == false
    assert  ElxValidation.DateTime.date_equals("", "1990-04-16") == false
  end
  test "is_after" do
    assert  ElxValidation.DateTime.is_after("1990-04-18", "1990-04-17") == true
    assert  ElxValidation.DateTime.is_after("1990-04-17", "1990-04-17") == false
    assert  ElxValidation.DateTime.is_after("", "1990-04-17") == false
    assert  ElxValidation.DateTime.is_after(nil, "1990-04-17") == false
    assert  ElxValidation.DateTime.is_after("", "") == false
    assert  ElxValidation.DateTime.is_after(nil, nil) == false
  end
  test "is_after_or_equal" do
    assert  ElxValidation.DateTime.is_after_or_equal("1990-04-18", "1990-04-17") == true
    assert  ElxValidation.DateTime.is_after_or_equal("1990-04-17", "1990-04-17") == true
    assert  ElxValidation.DateTime.is_after_or_equal("", "1990-04-17") == false
    assert  ElxValidation.DateTime.is_after_or_equal(nil, "1990-04-17") == false
    assert  ElxValidation.DateTime.is_after_or_equal("", "") == false
    assert  ElxValidation.DateTime.is_after_or_equal(nil, nil) == false
  end
  test "is_before" do
    assert  ElxValidation.DateTime.is_before("1990-04-18", "1990-04-19") == true
    assert  ElxValidation.DateTime.is_before("1990-04-17", "1990-04-17") == false
    assert  ElxValidation.DateTime.is_before("", "1990-04-17") == false
    assert  ElxValidation.DateTime.is_before(nil, "1990-04-17") == false
    assert  ElxValidation.DateTime.is_before("", "") == false
    assert  ElxValidation.DateTime.is_before(nil, nil) == false
  end
  test "is_before_or_equal" do
    assert  ElxValidation.DateTime.is_before_or_equal("1990-04-18", "1990-04-19") == true
    assert  ElxValidation.DateTime.is_before_or_equal("1990-04-17", "1990-04-17") == true
    assert  ElxValidation.DateTime.is_before_or_equal("", "1990-04-17") == false
    assert  ElxValidation.DateTime.is_before_or_equal(nil, "1990-04-17") == false
    assert  ElxValidation.DateTime.is_before_or_equal("", "") == false
    assert  ElxValidation.DateTime.is_before_or_equal(nil, nil) == false
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
end