# spec/active_model/sleeping_king_studios/validations/relations/many_spec.rb

require 'active_model/sleeping_king_studios/validations/relations/many'

RSpec.describe ActiveModel::SleepingKingStudios::Validations::Relations::Many do
  let(:instance) { described_class.new }

  describe '#validate' do
    it { expect(instance).to respond_to(:validate).with(1).argument }

    describe 'with a record' do
      let(:record) { Node.new }

      describe 'with no relations' do
        it 'should not change the errors' do
          expect { instance.validate record }.not_to change(record.errors, :messages)
        end # it
      end # describe

      describe 'with valid relations' do
        let(:relations) { %w(red green blue).map { |color| Edge.new(color) } }
        let(:record)    { super().tap { |obj| obj.relations = relations } }

        it 'should not change the errors' do
          expect { instance.validate record }.not_to change(record.errors, :messages)
        end # it
      end # describe

      describe 'with invalid relations' do
        let(:relations) { Array.new(3).map { Edge.new } }
        let(:record)    { super().tap { |obj| obj.relations = relations } }

        it 'should merge the relation errors into errors' do
          instance.validate record

          errors = record.errors
          expect(errors).not_to be_blank

          [*0...relations.count].each do |index|
            key = :"relations[#{index}][color]"

            expect(errors[key]).to contain_exactly "can't be blank"
          end # each
        end # it
      end # describe
    end # describe
  end # describe
end # describe
