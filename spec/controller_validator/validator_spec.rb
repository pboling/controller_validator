require 'spec_helper'

describe ControllerValidator::Validator, :classes do
  describe 'class methods' do

    describe '.human_attribute_name' do
      describe 'with required params' do
        it 'should not raise error' do
          expect { ControllerValidator::Validator.human_attribute_name(:thing) }.to_not raise_error
        end
        it 'should be empty string' do
          expect( ControllerValidator::Validator.human_attribute_name(:thing) ).to eq 'Thing'
        end
      end

      describe 'with optional params' do
        it 'should not raise error' do
          expect { ControllerValidator::Validator.human_attribute_name(:thing, {}) }.to_not raise_error
        end
        it 'should be empty string' do
          expect( ControllerValidator::Validator.human_attribute_name(:thing, {}) ).to eq 'Thing'
        end
      end
    end

    describe '.lookup_ancestors' do
      it 'should not raise error' do
        expect { ControllerValidator::Validator.lookup_ancestors }.to_not raise_error
      end
      it 'should be empty string' do
        expect( ControllerValidator::Validator.lookup_ancestors ).to eq [ControllerValidator::Validator]
      end
    end

  end

  describe 'instance methods' do
    let(:controller_validator) { ControllerValidator::Validator.new }

    describe '#validate_and_push_errors_to' do
      let(:active_model_validation_actual) { ControllerValidator::Validator.new }
      it 'should  raise error' do
        expect { controller_validator.validate_and_push_errors_to(instance: active_model_validation_actual) }.to raise_error
      end
    end

    describe '#validate!' do
      it 'should raise an error' do
        expect { controller_validator.validate! }.to raise_error
      end
    end

    describe '#read_attribute_for_validation' do
      it 'should raise error for missing attribute' do
        expect { controller_validator.read_attribute_for_validation(:thing) }.to raise_error
      end
      it 'should not raise error for actual attribute' do
        expect { controller_validator.read_attribute_for_validation(:errors) }.to_not raise_error
      end
      it 'should be nil' do
        expect( controller_validator.read_attribute_for_validation(:errors) ).to be_a ::ActiveModel::Errors
      end
    end
  end

end
