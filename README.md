# Romanian Validators [![Build Status](https://travis-ci.org/mtarnovan/romanianvalidators.svg?branch=master)](https://travis-ci.org/mtarnovan/romanianvalidators) [![Gem Version](https://badge.fury.io/rb/romanianvalidators.svg)](https://badge.fury.io/rb/romanianvalidators) [![Code Climate](https://codeclimate.com/github/mtarnovan/romanianvalidators/badges/gpa.svg)](https://codeclimate.com/github/mtarnovan/romanianvalidators)

Validators for:

  * Cod Numeric Personal (CNP)
  * Cod de identificare fiscală (CIF) and
  * IBAN (only Romanian format as published by Romanian National Bank).
  * BIC

Extracted from [openapi.ro](https://openapi.ro), business APIs for Romanian developers.
Includes `ActiveModel` validators.

## Installation

Include it in your `Gemfile`. If you just want the validation, without `ActiveModel`, use:

    gem 'romanianvalidators'

If you want ActiveModel integration, use instead:

    gem 'romanianvalidators', require: 'romanian_validators/active_model'

Has no other dependency (other than `ActiveModel` if you require it).

Tested with MRI 1.9.3, 2.0, 2.1, 2.3, REE, Rubinius and JRuby (see `.travis.yml`)

## Usage

Without `ActiveModel`, just call the `valid?` method on the corresponding module

```ruby
    > RomanianValidators::Cif.valid?(13548146)
    => true
    > RomanianValidators::Iban.valid?(123)
    => false
 ```

With `ActiveModel`, include it in your model

```ruby
    include RomanianValidators::ActiveModel::Validations
```

then use like this:

```ruby
    validates :my_attribute, cif: true
```

Example:
```ruby
    class User
      include ActiveModel::Model
      include RomanianValidators::ActiveModel::Validations
      attr_accessor :cnp, :company_cif

      validates :cnp, cnp: { message: 'This is not a valid CNP' }
      validates :company_cif, cif: true
    end

    > u = User.new(cnp: 123, company_cif: 123)
    => #<User:0x007fbf7f959b38 @cnp=123, @company_cif=123>
    > u.valid?
    => false
    > u.errors
    => #<ActiveModel::Errors:0x007fbf80958548 @base=#<User:0x007fbf7f959b38 @cnp=123, @company_cif=123, @validation_context=nil, @errors=#<ActiveModel::Errors:0x007fbf80958548 ...>>, @messages={:cnp=>["This is not a valid CNP"], :company_cif=>["is invalid"]}, @details={:cnp=>[{:error=>"This is not a valid CNP"}], :company_cif=>[{:error=>:invalid}]}>
```

For CIFs, a (lazy) enumerator is provided. This enumerator is significantly
more efficient than iterating over a range of numbers and filtering valid CIFs, because
it generates the control digit from `cif % 10` directly.

Example:

```ruby
> RomanianValidators::Cif.enumerator(1).take(10).to_a
=> [19, 27, 35, 43, 51, 60, 78, 86, 94, 108]
> RomanianValidators::Cif.enumerator(1_000_000, :down).take(10).to_a
=> [999993, 999985, 999977, 999969, 999950, 999942, 999934, 999926, 999918, 999900]
```

### Upgrading

If upgrading from `0.1.x`, note that the `ActiveModel` validations are now in a separate module so you need to add
`include RomanianValidators::ActiveModel::Validations` in your models. Additionaly you need to add a `require` in your Gemfile (again, only if using `ActiveModel`):

```ruby
  gem 'romanianvalidators', require: 'romanianvalidators/active_model'
```

### Changelog

#### 0.2.0
* moved validations from `ActiveModel::Validations` to `RomanianValidators::ActiveModel::Validations`.
  This module must be manually required in models.
* added a lazy enumerator that generates valid CIFs: `RomanianValidators::Cif.enumerator(start, direction = :up)`

### Copyright

Copyright (c) 2007-2018 Mihai Târnovan. MIT LICENSE. See LICENSE for details.
