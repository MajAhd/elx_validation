defmodule ElxValidation.AlphaTest do
  use ExUnit.Case
  doctest ElxValidation.Alpha

  test "is_alpha" do
    assert  ElxValidation.Alpha.is_alpha("alphabet string") == true
    assert  ElxValidation.Alpha.is_alpha("wrong string 123") == false
    assert  ElxValidation.Alpha.is_alpha(123) == false
  end
  test "is_string" do
    assert  ElxValidation.Alpha.is_string("alphabet string") == true
    assert  ElxValidation.Alpha.is_string("string 123") == true
    assert  ElxValidation.Alpha.is_string(123) == false
  end
  test "start_with" do
    assert  ElxValidation.Alpha.start_with("startMajid", "start") == true
    assert  ElxValidation.Alpha.start_with("startMajid", 123) == false
    assert  ElxValidation.Alpha.start_with(123456, 123) == false
  end
  test "end_with" do
    assert  ElxValidation.Alpha.end_with("Majidend", "end") == true
    assert  ElxValidation.Alpha.end_with("Majid123", 123) == false
    assert  ElxValidation.Alpha.end_with(456123, 123) == false
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

end
