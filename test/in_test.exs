defmodule ElxValidation.InTest do
  use ExUnit.Case
  doctest ElxValidation.In

  test "is in" do
    assert  ElxValidation.In.is_in("john", "victor,alex,john") == true
    assert  ElxValidation.In.is_in("john", "victor,alex,tommy") == false
    assert  ElxValidation.In.is_in("", "victor,alex,tommy") == false
    assert  ElxValidation.In.is_in(nil, "victor,alex,tommy") == false
  end

  test "is not in" do
    assert  ElxValidation.In.is_not_in("john", "victor,alex,tom") == true
    assert  ElxValidation.In.is_not_in("john", "victor,alex,john") == false
    assert  ElxValidation.In.is_not_in("", "victor,alex,john") == true
    assert  ElxValidation.In.is_not_in(nil, "victor,alex,john") == true
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
end