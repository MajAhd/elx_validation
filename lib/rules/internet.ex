defmodule ElxValidation.Internet do
  @moduledoc """
  ### email
  - The field under validation must be formatted as an email address.
  ### url
  - The field under validation must be a valid URL.
  ### ip
  - The field under validation must be an IP address.
  ### ipv4
  - The field under validation must be an IPv4 address.
  ### ipv6
  - The field under validation must be an IPv6 address.
  ***
  ```
  data = %{
      email: "example@gmail.com",
      url: "http://google.com",
      ip: "192.168.1.1",
      ipv4: "192.168.1.1",
      ipv6: "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
    }
  rules = [
      %{
        field: "email",
        validate: ["email"]
      },
      %{
        field: "url",
        validate: ["url"]
      },
      %{
        field: "ip",
        validate: ["ip"]
      },
      %{
        field: "ipv4",
        validate: ["ipv4"]
      },
      %{
        field: "ipv6",
        validate: ["ipv6"]
      }
    ]
  ```
  """
  @doc """
  check Email Address
  """
  def email(target) do
    Regex.match?(~r/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/, target)
  rescue
    _ ->
      false
  end
  @doc """
  check Url Address
  """
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
  @doc """
    check IP Address IPV4
  """
  def ipv4(target) do
    Regex.match?(
      ~r/^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/,
      target
    )
  rescue
    _ ->
      false
  end
  @doc """
    check IP Address IPV6
  """
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
