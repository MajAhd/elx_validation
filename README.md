# elx_validation

[![Build Status](https://www.travis-ci.com/MajAhd/elx_validation.svg?branch=main)](https://www.travis-ci.com/MajAhd/elx_validation)

Simple and easy library to Validate data

⚠️ Library under develop

## install
```
mix.exs
{:elx_validation, "~> 0.1.0"}

mix deps.get
```

## Usage
***
```
data = %{
    name: "Majid ahd",
    email: "example@email.com"
}

rules = [
%{
    field: "name",
    as: "first name",
    validate: ["required", "min:4", "max:10"]
},
%{
    field: "email",
    validate: ["required", "email"]
}]
```

## Documentation
[ElxValidation](https://hexdocs.pm/elx_validation/)

## Wiki
***
- [Start Validation](https://github.com/MajAhd/elx_validation/wiki)
- [Required](https://github.com/MajAhd/elx_validation/wiki/Required)
- [Accepted](https://github.com/MajAhd/elx_validation/wiki/Accepted)
- [Alpha & String](https://github.com/MajAhd/elx_validation/wiki/Alpha-and-String)
- [Boolean](https://github.com/MajAhd/elx_validation/wiki/Boolean)
- [Numbers](https://github.com/MajAhd/elx_validation/wiki/Numbers)
- [Min & Max](https://github.com/MajAhd/elx_validation/wiki/Max-&-Min)
- [Internet](https://github.com/MajAhd/elx_validation/wiki/Internet-Address-:-email-,-url-,-ip)
- [In & Not_In](https://github.com/MajAhd/elx_validation/wiki/in-&-not-in)
- [UUID](https://github.com/MajAhd/elx_validation/wiki/uuid)
- [Date&Time](https://github.com/MajAhd/elx_validation/wiki/Date-and-Time)
- [Different](https://github.com/MajAhd/elx_validation/wiki/Greater-that-&-Less-Than-&-equal-&-Different-Field)
- [Confirmation](https://github.com/MajAhd/elx_validation/wiki/Confirmation)
- [Nullable](https://github.com/MajAhd/elx_validation/wiki/Nullable)

## Author
***
 Majid Ahmaditabar

ElxValidation is released under the [MIT License](https://github.com/MajAhd/elx_validation/blob/main/LICENSE).