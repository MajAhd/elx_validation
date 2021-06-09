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
end
