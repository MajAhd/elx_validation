defmodule ElxValidation.DateTime do
  @moduledoc """
  ### date
  - The field under validation must be a valid, non-relative date.
   - "2020-06-26"

  ### time

  - The field under validation must be a valid, non-relative time.
  - am / pm is optional
   - "20:13"
   - "01:02"
   - "02:40am"
   - "05:20pm"

  ### datetime

  - The field under validation must be a valid datetime identifier
  - "2020-06-26 12:20"


  ### timezone

  - The field under validation must be a valid timezone identifier
    - "+04:30"
    - "-01:30"

  ```
  data = %{
      birthdate: "1990-04-17",
      start_time: "13:30",
      expired: "2020-06-28 12:20",
      my_zone: "+04:30"
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
  ```
  ### date_equals:date
  - The field under validation must be equal to the given date.
  ### after:date
  - The field under validation must be a value after a given date.
  ### after_or_equal:date
  - The field under validation must be a value after or equal to the given date. For more information, see the after rule.
  ### before:date
  - The field under validation must be a value preceding the given date.
  ### before_or_equal:date
  - The field under validation must be a value preceding or equal to the given date.
  ```
  data = %{
      eq_bd: "1990-04-17",   ---> == "1990-04-17"
      after_bd: "1990-04-20",  ---> > "1990-04-17"
      after_equal_bd: "1990-04-18", ---> >= "1990-04-17"
      before_bd: "1990-04-16",  ---> < "1990-04-17"
      before_equal_bd: "1990-04-17",  ---> <= "1990-04-17"
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
  ```
  """
  @doc """
     check target is Date
  """
  def is_date(target) do
    Regex.match?(~r/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/, target)
  rescue
    _ ->
      false
  end

  @doc """
     check target is Time
     - 01:12am -> passed
     - 04:30pm -> passed
     - 13:12   -> passed
     - am /pm  -> optional
  """
  def is_time(target) do
    Regex.match?(~r/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]([AaPp][Mm])?$/, target)
  rescue
    _ ->
      false
  end
  @doc """
     check target is DateTime
      - YYYY-MM-DD HH:MM:SS  -> passed
  """
  def is_date_time(target) do
    Regex.match?(~r/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])) ([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, target)
  rescue
    _ ->
      false
  end
  @doc """
     check target is Timezone data
      - +04:30 -> passed
      - -01:15   -> passed
  """
  def is_timezone(target) do
    Regex.match?(~r/[+-][0-9]{2}:[0-9]{2}\b/, target)
  rescue
    _ ->
      false
  end
  @doc """
     check target and value is date and equal
  """
  def date_equals(target, value) do
    if is_date(target) and is_date(value) do
      t = Date.from_iso8601!(target)
      v = Date.from_iso8601!(value)
      Date.diff(v, t) == 0
    else
      false
    end
  rescue
    _ ->
      false
  end
  @doc """
     check target and value is date and target after value
  """
  def is_after(target, value) do
    if is_date(target) and is_date(value) do
      t = Date.from_iso8601!(target)
      v = Date.from_iso8601!(value)
      Date.diff(t, v) > 0
    else
      false
    end
  rescue
    _ ->
      false
  end

  @doc """
     check target and value is date and target after or equal value
  """
  def is_after_or_equal(target, value) do
    if is_date(target) and is_date(value) do
      t = Date.from_iso8601!(target)
      v = Date.from_iso8601!(value)
      Date.diff(t, v) >= 0
    else
      false
    end
  rescue
    _ ->
      false
  end

  @doc """
     check target and value is date and target before value
  """
  def is_before(target, value) do
    if is_date(target) and is_date(value) do
      t = Date.from_iso8601!(target)
      v = Date.from_iso8601!(value)
      Date.diff(t, v) < 0
    else
      false
    end
  rescue
    _ ->
      false
  end

  @doc """
     check target and value is date and target before or equal value
  """
  def is_before_or_equal(target, value) do
    if is_date(target) and is_date(value) do
      t = Date.from_iso8601!(target)
      v = Date.from_iso8601!(value)
      Date.diff(t, v) <= 0
    else
      false
    end
  rescue
    _ ->
      false
  end
end
