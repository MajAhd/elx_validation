defmodule ElxValidation.DateTime do
  @moduledoc """
     Run Check Date and Time data
  """
  @doc """
     check target is Date
  """
  def is_date(target) do  end

  @doc """
     check target is Time
     01:12am
     04:30pm
     13:12
  """
  def is_time(target) do  end
  @doc """
     check target is DateTime
      YYYY-MM-DD HH:MM:SS
  """
  def is_date_time(target) do  end
  @doc """
     check target is Timezone data
  """
  def is_timezone(target) do  end
  @doc """
     check target and value is date and equal
  """
  def date_equals(target, value) do  end
  @doc """
     check target and value is date and target after value
  """
  def is_after(target, value) do  end
  @doc """
     check target and value is date and target after or equal value
  """
  def is_after_or_equal(target, value) do  end
  @doc """
     check target and value is date and target before value
  """
  def is_before(target, value) do  end
  @doc """
     check target and value is date and target before or equal value
  """
  def is_before_or_equal(target, value) do  end
end
