# spec/active_model/sleeping_king_studios/concern_spec.rb

require 'active_model/sleeping_king_studios/concern'

RSpec.describe ActiveModel::SleepingKingStudios::Concern do
  let(:concern) do
    Module.new do
      extend ActiveModel::SleepingKingStudios::Concern
    end # let
  end # let
  let(:described_class) do
    klass = Class.new
    klass.send :include, concern
    klass
  end # let
  let(:instance) { described_class.new }

  describe '::characterize' do
    it { expect(concern).to respond_to(:characterize).with(2..3).arguments }

    let(:name)       { :concern }
    let(:properties) { { :key => :value } }

    let(:metadata) { concern.characterize name, properties }

    it 'creates the metadata' do
      expect(metadata).to be_a ActiveModel::SleepingKingStudios::Concern::Metadata
    end # it

    it 'sets the value' do
      concern.characterize name, properties
      expect(metadata[:key]).to be == :value
    end # it

    context 'with a type specified' do
      let(:type) do
        Class.new(ActiveModel::SleepingKingStudios::Concern::Metadata) do
          def key
            self[:key]
          end # method key
        end # class
      end # let

      let(:metadata) { concern.characterize name, properties, type }

      it 'creates the metadata' do
        expect(metadata).to be_a type
      end # it

      it 'sets the value' do
        expect(metadata.key).to be == :value
      end # it
    end # context
  end # describe

  describe '::relate' do
    let(:name)       { :concern }
    let(:properties) { {} }
    let(:metadata)   { ActiveModel::SleepingKingStudios::Concern::Metadata.new name, properties }

    it { expect(concern).to respond_to(:relate).with(3).arguments }

    it 'updates the relations' do
      concern.relate described_class, name, metadata

      expect(described_class.sleeping_king_studios_concerns).to be == { metadata.concern_key => metadata }
    end # it
  end # describe

  describe '::sleeping_king_studios_concerns' do
    it { expect(described_class).to have_reader(:sleeping_king_studios_concerns).with({}) }
  end # describe

  describe '::valid_options' do
    it { expect(concern).to respond_to(:valid_options).with(0).arguments }

    it { expect(concern.valid_options).to be_a(Array).& be_empty }
  end # describe

  describe '::validate_options' do
    let(:name) { :concern }

    it { expect(concern).to respond_to(:validate_options).with(1, :receiver).arguments }

    describe 'with invalid options' do
      let(:options) { { :defenestrate => true } }

      it 'raises an error' do
        expect {
          concern.validate_options options
        }.to raise_error ActiveModel::SleepingKingStudios::Errors::InvalidOptionsError
      end # it

      describe 'with a named receiver' do
        let(:receiver) { 'Receiver#i_hardly_knew_her' }

        it 'raises an error' do
          expect {
            concern.validate_options options, :receiver => receiver
          }.to raise_error ActiveModel::SleepingKingStudios::Errors::InvalidOptionsError
        end # it
      end # describe
    end # context
  end # describe
end # describe
