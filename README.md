# ControllerValidator

Simple Validations in the Controller!
(Re)Use the familiar ActiveModel::Errors pattern for controller validations, so you already know how this works.

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
