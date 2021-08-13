defmodule ElxValidation.Storage do
  @moduledoc """
  ### File
  - the field under validation must be a file and at leas 1 kilobyte size
  - empty value return error unless field is under nullable validation

  ```
    data = %{
      logo: "LOGO FILE",
    }
    rules = [
      %{
        field: "logo",
        validate: ["file","min_size:10","max_size:20","mimes:png,jpg","mime_types:image/png,image/jpeg"]
      },
    ]
   ```

   - file : data must be a file and at least 1 kb size
   - min_size: minimum size (Kb) of file
   - max_size: maximum size (Kb) of file
   - mimes: list of accepted mimes
   - mime_types: list of accepted mime_types
  """

  def is_file(target) do
    if File.exists?(target.path) do
      true
    else
      false
    end
  rescue
    _ ->
      false
  end

  def max_size(target, value) do
    if is_file(target) do
      %{size: size} = File.stat!(target.path)

      cond do
        div(size, 1024) <= String.to_integer(value) -> true
        div(size, 1024) > String.to_integer(value) -> false
        true -> false
      end
    else
      false
    end
  rescue
    _ ->
      false
  end

  def min_size(target, value) do
    if is_file(target) do
      %{size: size} = File.stat!(target.path)

      cond do
        div(size, 1024) >= String.to_integer(value) -> true
        div(size, 1024) < String.to_integer(value) -> false
        true -> false
      end
    else
      false
    end
  rescue
    _ ->
      false
  end

  def mimes(target, value) do
    if is_file(target) do
      extension = Path.extname(target.filename)

      v =
        value
        |> String.split(",")

      Enum.find(v, fn x -> "." <> x == extension end) != nil
    else
      false
    end
  rescue
    _ ->
      false
  end

  def mime_types(target, value) do
    if is_file(target) do
      v =
        value
        |> String.split(",")

      Enum.find(v, fn x -> x == target.content_type end) != nil
    else
      false
    end
  rescue
    _ ->
      false
  end
end
