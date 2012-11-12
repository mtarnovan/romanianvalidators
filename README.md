# Romanian Validators

Rails validators for: 

  * Cod Numeric Personal (CNP)
  * Cod de identificare fiscală (CIF) and 
  * IBAN (only Romanian format as published by Romanian National Bank).

[![Build Status](https://travis-ci.org/mtarnovan/romanianvalidators.png)](https://travis-ci.org/mtarnovan/romanianvalidators)

## Installation

### In a Rails 3 app, as a gem

First include it in your Gemfile.

    $ cat Gemfile
    ...
    gem 'romanianvalidations'
    ...

Next install it with Bundler.

    $ bundle install

## Usage

In your models (ActiveModel), the gem provides the following new validators:
* CIF
* CNP
* IBAN
* BIC

The algorithms for validation are found in the source code.

```ruby
    class User
      validates :cnp,             :cnp   => true
      validates :company_cif,     :cif => true
    end
```

### TODO

  * test more edge cases; test nil, blank; test messages; test in app

### Copyright

Copyright (c) 2007-2012 Mihai Târnovan. MIT LICENSE. See LICENSE for details.
