# ControllerValidator

Simple Validations in the Controller!
(Re)Use the familiar ActiveModel::Errors pattern for controller validations, so you already know how this works.

| Project                 |  ControllerValidator    |
|------------------------ | ----------------- |
| gem name                |  controller_validator   |
| license                 |  MIT              |
| expert support          |  [![Get help on Codementor](https://cdn.codementor.io/badges/get_help_github.svg)](https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github) |
| download rank               |  [![Total Downloads](https://img.shields.io/gem/rt/controller_validator.svg)](https://rubygems.org/gems/controller_validator) |
| version                 |  [![Gem Version](https://badge.fury.io/rb/controller_validator.png)](http://badge.fury.io/rb/controller_validator) |
| dependencies            |  [![Dependency Status](https://gemnasium.com/pboling/controller_validator.png)](https://gemnasium.com/pboling/controller_validator) |
| code quality            |  [![Code Climate](https://codeclimate.com/github/pboling/controller_validator.png)](https://codeclimate.com/github/pboling/controller_validator) |
| inline documenation     |  [![Inline docs](http://inch-ci.org/github/pboling/controller_validator.png)](http://inch-ci.org/github/pboling/controller_validator) |
| continuous integration  |  [![Build Status](https://secure.travis-ci.org/pboling/controller_validator.png?branch=master)](https://travis-ci.org/pboling/controller_validator) |
| test coverage           |  [![Coverage Status](https://coveralls.io/repos/pboling/controller_validator/badge.png)](https://coveralls.io/r/pboling/controller_validator) |
| homepage                |  [on Github.com][homepage] |
| documentation           |  [on Rdoc.info][documentation] |
| live chat               |  [![Join the chat at https://gitter.im/pboling/controller_validator](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/pboling/controller_validator?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) |
| Spread ~♡ⓛⓞⓥⓔ♡~      |  [on Coderbits][coderbits], [on Coderwall][coderwall] |

[semver]: http://semver.org/
[pvc]: http://docs.rubygems.org/read/chapter/16#page74
[railsbling]: http://www.railsbling.com
[peterboling]: http://www.peterboling.com
[coderbits]: https://coderbits.com/pboling
[coderwall]: http://coderwall.com/pboling
[documentation]: http://rubydoc.info/gems/controller_validator
[homepage]: https://github.com/pboling/controller_validator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'controller_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install controller_validator

## Usage

See the integration specs!

```ruby
class ThingController < ApplicationController

  def create

    @thing = Thing.new

    validator = ValidateThingOnCreate.new()
    validator.validate_and_push_errors_to(instance: @thing)

    # So far save has not been called on @thing, no callbacks have been run, the model is not involved at all

    if @thing.errors.any?
      render :new
    else
      if @thing.save
        redirect_to @thing_path(id: @thing.id)
      else
        render :new
      end
    end
  end

end

class ValidateThingOnCreate < ControllerValidator::Validator

  # Rules for creating a new thing
  # 1. There must not be too many things already
  # 2. There must be no Bobs

  attr_accessor :too_many, :no_bobs

  def initialize()
    @too_many = Thing.count > 100
    @no_bobs = Bob.count == 0
    super
  end

  def validate!
    errors.add(:too_many, "must not be true") if !self.too_many
    errors.add(:no_bobs, "must be true") if !self.no_bobs
    errors.blank?
  end

end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/controller_validator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
