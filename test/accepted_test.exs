defmodule AcceptedTest do
  use ExUnit.Case
  doctest ElxValidation.Accepted
   test "is_accepted" do
     assert ElxValidation.Accepted.is_accepted("true") == true
     assert ElxValidation.Accepted.is_accepted(true) == true
     assert ElxValidation.Accepted.is_accepted("yes") == true
     assert ElxValidation.Accepted.is_accepted("on") == true
     assert ElxValidation.Accepted.is_accepted("1") == true
     assert ElxValidation.Accepted.is_accepted(1) == true
     assert ElxValidation.Accepted.is_accepted(0) == false
     assert ElxValidation.Accepted.is_accepted(false) == false
     assert ElxValidation.Accepted.is_accepted("false") == false
     assert ElxValidation.Accepted.is_accepted("no") == false
  end
end
