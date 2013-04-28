# Romanian Validators [![Build Status](https://travis-ci.org/mtarnovan/romanianvalidators.png)](https://travis-ci.org/mtarnovan/romanianvalidators) [![Gem Version](https://badge.fury.io/rb/romanianvalidators.png)](http://badge.fury.io/rb/romanianvalidators) [![Code Climate](https://codeclimate.com/github/mtarnovan/romanianvalidators.png)](https://codeclimate.com/github/mtarnovan/romanianvalidators)

ActiveModel validators for:

  * Cod Numeric Personal (CNP)
  * Cod de identificare fiscală (CIF) and
  * IBAN (only Romanian format as published by Romanian National Bank).
  * BIC

Extracted from [Factureaza.ro](https://factureaza.ro), our online invoicing solution for the Romanian market.

## Installation

### In a Rails 3 app, as a gem

First include it in your Gemfile.

    $ cat Gemfile
    ...
    gem 'romanianvalidations'
    ...

Next install it with Bundler.

    $ bundle install

Has no other dependency than `ActiveModel`, so it should work without Rails too.

Tested with MRI 1.8.7, 1.9.3, 2.0.0, REE, Rubinius and JRuby (see `.travis.yml`)

## Usage

In your models (`ActiveModel`), the gem provides the following new validators:
* CIF
* CNP
* IBAN
* BIC

The algorithms for validation are found in the source code.

```ruby
    class User
      validates :cnp,             :cnp   => { :message => 'This is not a valid CNP'}
      validates :company_cif,     :cif => true
    end
```

### TODO

  * test more edge cases
  * add javascript validation ?

### Copyright

Copyright (c) 2007-2013 Mihai Târnovan. MIT LICENSE. See LICENSE for details.
