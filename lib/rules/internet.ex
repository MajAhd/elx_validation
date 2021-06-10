defmodule ElxValidation.Internet do
  @moduledoc """
  Run Check Internet data
   - internet.INTERNET_VALIDATE(value)
   - if value was one of the validators return true
  """
  @doc """
  Internet Data (INTERNET_VALIDATE) included :
  - email
  - ip
  - ipv4
  - ipv6
  - url
  """
  def email(target) do
    Regex.match?(~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/, target)
  rescue
    _ ->
      false
  end
  def url(target) do
    Regex.match?(~r/(https?:\/\/)?([\w\-])+\.{1}([a-zA-Z]{2,63})([\/\w-]*)*\/?\??([^#\n\r]*)?#?([^\n\r]*)/, target)
  rescue
    _ ->
      false
  end
  @doc """
    check IP Address IPV4 /IPV6
  """
  def ip(target) do
    ipv4(target) || ipv6(target)
  rescue
    _ ->
      false
  end
  def ipv4(target) do
    Regex.match?(
      ~r/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/,
      target
    )
  rescue
    _ ->
      false
  end
  def ipv6(target) do
    Regex.match?(
      ~r/^(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))$/,
      target
    )
  rescue
    _ ->
      false
  end
end
