defmodule ElxValidation.BooleanTest do
  use ExUnit.Case
  doctest ElxValidation.Boolean

  test "validate_boolean" do
    assert  ElxValidation.Boolean.validate_boolean("true") == true
    assert  ElxValidation.Boolean.validate_boolean("false") == true
    assert  ElxValidation.Boolean.validate_boolean("0") == true
    assert  ElxValidation.Boolean.validate_boolean("1") == true
    assert  ElxValidation.Boolean.validate_boolean(true) == true
    assert  ElxValidation.Boolean.validate_boolean(false) == true
    assert  ElxValidation.Boolean.validate_boolean(0) == true
    assert  ElxValidation.Boolean.validate_boolean(1) == true
    assert  ElxValidation.Boolean.validate_boolean(10) == false
    assert  ElxValidation.Boolean.validate_boolean("yes") == false
    assert  ElxValidation.Boolean.validate_boolean(nil) == false
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

end