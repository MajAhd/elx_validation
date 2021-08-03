defmodule ElxValidation.StorageTest do
  use ExUnit.Case
  doctest ElxValidation.Storage
  test "is file failed" do

    data = %{
      logo: "./assets/ElxValidation.png",
    }
    rules = [
      %{
        field: "logo",
        validate: ["file", "min_size:10", "max_size:20", "mimes:png,jpg", "mime_types:image/png,image/jpeg"]
      },
    ]
    assert ElxValidation.make(data, rules) == %{
             errors: [
               logo: [
                 "The logo must be a file.",
                 "The logo  must be at least 10 kilobytes.",
                 "The logo may not be greater than 20 kilobytes.",
                 "The logo must be a file of type: png,jpg.",
                 "The logo must be a file of type: image/png,image/jpeg."
               ]
             ],
             failed: true
           }
  end
end