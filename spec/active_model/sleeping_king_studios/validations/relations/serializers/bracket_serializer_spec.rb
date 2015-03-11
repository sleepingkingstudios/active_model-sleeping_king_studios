# spec/active_model/sleeping_king_studios/validations/relations/serializers/bracket_serializer_spec.rb

require 'spec_helper'

require 'active_model/sleeping_king_studios/validations/relations/serializers/bracket_serializer'

RSpec.describe ActiveModel::SleepingKingStudios::Validations::Relations::Serializers::BracketSerializer do
  describe '::deserialize' do
    it { expect(described_class).to respond_to(:deserialize).with(1).argument }

    describe 'with a simple symbol parameter' do
      it 'should return an array containing the parameter as a string' do
        expect(described_class.deserialize :foo).to be == %w(foo)
      end # it
    end # describe

    describe 'with a bracket-delineated symbol parameter' do
      it 'should return an array containing the parameters as strings' do
        expect(described_class.deserialize :'foo[bar][baz]').to be == %w(foo bar baz)
      end # it
    end # describe
  end # describe

  describe '::serialize' do
    it { expect(described_class).to respond_to(:serialize).with(1..9001).arguments }

    describe 'with one parameter' do
      it 'should return the parameter as a symbol' do
        expect(described_class.serialize *%w(foo)).to be == :foo
      end # it
    end # describe

    describe 'with many parameters' do
      it 'should return the parameters as a bracket-delineated symbol' do
        expect(described_class.serialize *%w(foo bar baz)).to be == :'foo[bar][baz]'
      end # it
    end # describe
  end # describe
end # describe
