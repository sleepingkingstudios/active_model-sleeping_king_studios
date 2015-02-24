# spec/active_model/sleeping_king_studios/validations/relations/one_spec.rb

require 'active_model/sleeping_king_studios/validations/relations/one'

RSpec.describe ActiveModel::SleepingKingStudios::Validations::Relations::One do
  let(:instance) { described_class.new }

  describe '#validate' do
    it { expect(instance).to respond_to(:validate).with(1).argument }

    describe 'with a record' do
      let(:record) { Axiom.new }

      describe 'with no relations' do
        it 'should not change the errors' do
          expect { instance.validate record }.not_to change(record.errors, :messages)
        end # it
      end # describe

      describe 'with a valid relation' do
        let(:relation) { Proof.new(false) }
        let(:record)   { super().tap { |obj| obj.relation = relation } }

        it 'should not change the errors' do
          expect { instance.validate record }.not_to change(record.errors, :messages)
        end # it
      end # describe

      describe 'with an invalid relation' do
        let(:relation) { Proof.new(:maybe) }
        let(:record)   { super().tap { |obj| obj.relation = relation } }

        it 'should merge the relation errors into errors' do
          instance.validate record

          errors = record.errors
          expect(errors).not_to be_blank

          key = :"relation[correct]"
          expect(errors[key]).to contain_exactly "is not included in the list"
        end # it
      end # describe
    end # describe
  end # describe
end # describe
