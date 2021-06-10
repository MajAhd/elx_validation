defmodule ElxValidation.UuidTest do
  use ExUnit.Case
  doctest ElxValidation.Uuid

  test "is_uuid" do
    assert  ElxValidation.Uuid.is_uuid("56b2724e-9074-4dc3-9803-4bb13c92ee0e") == true
    assert  ElxValidation.Uuid.is_uuid("56b272-9074-4dc3-9803-4bb13c92ee0e") == false
    assert  ElxValidation.Uuid.is_uuid("56b2724e-9074-4dc3-9803") == false
    assert  ElxValidation.Uuid.is_uuid("") == false
    assert  ElxValidation.Uuid.is_uuid(nil) == false
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

end