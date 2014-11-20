require 'active_model'

# Nearly entirely lifted from the example code in the Rails Documentation.
# See: http://www.rubydoc.info/docs/rails/ActiveModel/Errors
class ControllerValidator::Validator

  include ::ActiveModel::Validations

  attr_reader   :errors

  def initialize(*args)
    @errors = ::ActiveModel::Errors.new(self)
  end

  def validate_and_push_errors_to(instance:)
    unless self.validate!
      self.errors.full_messages.each do |message|
        instance.errors.add(:base, message)
      end
    end
  end

  def validate
    raise RuntimeError, 'Must be defined in subclass of ControllerValidator'
  end

  # The following methods are needed to be minimally implemented

  def read_attribute_for_validation(attr)
    send(attr)
  end

  def self.human_attribute_name(attr, options = {})
    attr.to_s.humanize
  end

  def self.lookup_ancestors
    [self]
  end

end

