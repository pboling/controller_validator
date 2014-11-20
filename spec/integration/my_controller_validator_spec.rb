# Integration Spec

class MyControllerValidator < ControllerValidator::Validator
  attr_accessor :thing
  def initialize(thing:)
    @thing = thing
    super
  end
  def validate!
    self.errors.add(:thing, 'monkeys are flying')
    self.errors.add(:base, 'cheese so good')
    self.errors.blank?
  end
end

describe MyControllerValidator, :classes do

  describe 'instance methods' do
    let(:controller_validator) { MyControllerValidator.new(thing: 'hey') }

    describe '.push_errors_to' do
      let(:active_model_validation_actual) { ControllerValidator::Validator.new }
      it 'should not raise error' do
        # instance just needs to be something that implements ActiveModel::Validations
        expect { controller_validator.validate_and_push_errors_to(instance: active_model_validation_actual) }.to_not raise_error
      end
      it 'should be empty string' do
        expect( controller_validator.validate_and_push_errors_to(instance: active_model_validation_actual) ).to eq ['Thing monkeys are flying','cheese so good']
      end
      it 'should add errors to the instance' do
        controller_validator.validate_and_push_errors_to(instance: active_model_validation_actual)
        expect( active_model_validation_actual.errors.full_messages ).to eq ['Thing monkeys are flying','cheese so good']
      end
    end

    describe '#validate!' do
      it 'should not raise an error' do
        expect { controller_validator.validate! }.to_not raise_error
      end
      it 'should be false' do
        expect( controller_validator.validate! ).to eq false
      end
    end

    describe '#read_attribute_for_validation' do
      it 'should not raise error' do
        expect { controller_validator.read_attribute_for_validation(:thing) }.to_not raise_error
      end
      it 'should be nil' do
        expect( controller_validator.read_attribute_for_validation(:thing) ).to eq 'hey'
      end
    end

  end

end
