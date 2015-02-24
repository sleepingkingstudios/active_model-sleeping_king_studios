# spec/active_model/sleeping_king_studios/validations/relations_spec.rb

require 'spec_helper'

require 'active_model/sleeping_king_studios/validations/relations'
require 'active_model/sleeping_king_studios/validations/relations/serializers/underscore_serializer'

RSpec.describe ActiveModel::SleepingKingStudios::Validations::Relations do
  let(:described_class) { Class.new.send(:include, ActiveModel::Validations).send(:include, super()) }

  describe '::validates_related_records' do
    it { expect(described_class).to respond_to(:validates_related_documents).with(1..2).arguments }

    it { expect(described_class).to respond_to(:validates_related_records).with(1..2).arguments }

    describe 'with :inventor' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::SleepingKingStudios::Validations::Relations::One

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :inventor
        end # expect

        described_class.validates_related_records :inventor
      end # it
    end # describe

    describe 'with :widgets' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::SleepingKingStudios::Validations::Relations::Many

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :widgets
        end # expect

        described_class.validates_related_records :widgets
      end # it
    end # describe

    describe 'with :sheep, :arity => :one' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::SleepingKingStudios::Validations::Relations::One

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :sheep
        end # expect

        described_class.validates_related_records :sheep
      end # it
    end # describe

    describe 'with :sheep, :arity => :many' do
      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::SleepingKingStudios::Validations::Relations::Many

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :sheep
        end # expect

        described_class.validates_related_records :sheep, :arity => :many
      end # it
    end # describe

    describe 'with :trolls, :arity => :trololol' do
      it 'raises an error' do
        expect {
          described_class.validates_related_records :trolls, :arity => :trololol
        }.to raise_error ArgumentError, /unrecognized arity/
      end # it
    end # describe

    describe 'with :patents, :serializer => UnderscoreSerializer' do
      let(:serializer) { ActiveModel::SleepingKingStudios::Validations::Relations::Serializers::UnderscoreSerializer }

      it 'should set a validation on the base class' do
        expect(described_class).to receive(:validates_with) do |validator_class|
          expect(validator_class).to be < ActiveModel::SleepingKingStudios::Validations::Relations::Many

          validator = validator_class.new
          expect(validator.send :relation_name).to be == :patents
          expect(validator.send :serializer).to be == serializer
        end # expect

        described_class.validates_related_records :patents, :serializer => serializer
      end # it
    end # describe
  end # describe
end # describe
