defmodule ElxValidation.DateTime do
  @moduledoc """
     Run Check Date and Time data
  """
  @doc """
     check target is Date
  """
  def is_date(target) do
    Regex.match?(~r/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/, target)
  end

  @doc """
     check target is Time
     01:12am
     04:30pm
     13:12
     am /pm is optional
  """
  def is_time(target) do
    Regex.match?(~r/^([0-1]?[0-9]|2[0-3]):[0-5][0-9]([AaPp][Mm])?$/, target)
  end
  @doc """
     check target is DateTime
      YYYY-MM-DD HH:MM:SS
  """
  def is_date_time(target) do
    Regex.match?(~r/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])) ([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/, target)
  end
  @doc """
     check target is Timezone data
      +04:30
      -01:15
  """
  def is_timezone(target) do
    Regex.match?(~r/[+-][0-9]{2}:[0-9]{2}\b/, target)
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
  end
end
