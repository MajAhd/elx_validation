defmodule ElxValidation.InternetTest do
  use ExUnit.Case
  doctest ElxValidation.Internet
  test "email" do
    assert  ElxValidation.Internet.email("example@email.com") == true
    assert  ElxValidation.Internet.email("example@email") == false
    assert  ElxValidation.Internet.email("exampleemail.com") == false
    assert  ElxValidation.Internet.email("") == false
    assert  ElxValidation.Internet.email(nil) == false
  end

  test "url" do
    assert  ElxValidation.Internet.url("www.google.com") == true
    assert  ElxValidation.Internet.url("google.com") == true
    assert  ElxValidation.Internet.url("https://www.google.com") == true
    assert  ElxValidation.Internet.url("https://google.com") == true
    assert  ElxValidation.Internet.url("http://www.google.com") == true
    assert  ElxValidation.Internet.url("http://google.com") == true
    assert  ElxValidation.Internet.url("google") == false
    assert  ElxValidation.Internet.url("") == false
    assert  ElxValidation.Internet.url(nil) == false
  end

  test "ip address" do
    assert  ElxValidation.Internet.ip("192.168.1.1") == true
    assert  ElxValidation.Internet.ip("2001:0db8:85a3:0000:0000:8a2e:0370:7334") == true
    assert  ElxValidation.Internet.ip("2001:0db8:85a3:0000:0000:8a2e:0370") == false
    assert  ElxValidation.Internet.ip("192.168.1") == false
    assert  ElxValidation.Internet.ip("") == false
    assert  ElxValidation.Internet.ip(nil) == false

    assert  ElxValidation.Internet.ipv4("192.168.1.1") == true
    assert  ElxValidation.Internet.ipv4("192.168.1") == false
    assert  ElxValidation.Internet.ipv4("") == false
    assert  ElxValidation.Internet.ipv4(nil) == false

    assert  ElxValidation.Internet.ipv6("2001:0db8:85a3:0000:0000:8a2e:0370:7334") == true
    assert  ElxValidation.Internet.ipv6("2001:0db8:85a3:0000:0000:8a2e:0370") == false
    assert  ElxValidation.Internet.ipv6("") == false
    assert  ElxValidation.Internet.ipv6(nil) == false
  end
  #  test internet addresses
  test "internet passed" do
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
    assert ElxValidation.make(data, rules) == %{errors: [], failed: false}
  end
  test "internet failed" do
    data = %{
      email: "example.com",
      url: "http://google",
      ip: "192.168.1",
      ipv4: "192.168.1",
      ipv6: "2001:0db8:85a3:0000:0000:8a2e"
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
    assert ElxValidation.make(data, rules) == %{
             errors: [
               email: ["The email must be a valid email address."],
               url: ["The url  must be a valid URL address."],
               ip: ["The ip must be a valid IP address."],
               ipv4: ["The ipv4 must be a valid IPv4 address."],
               ipv6: ["The ipv6 must be a valid IPv6 address."]
             ],
             failed: true
           }
  end
end