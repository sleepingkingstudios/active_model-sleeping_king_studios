# spec/active_model/sleeping_king_studios/concern/metadata_spec.rb

require 'active_model/sleeping_king_studios/concern/metadata'

RSpec.describe ActiveModel::SleepingKingStudios::Concern::Metadata do
  let(:name)       { :concern }
  let(:properties) { {} }
  let(:instance)   { described_class.new name, properties }

  describe '#initialize' do
    context 'with empty properties' do
      let(:properties) { {} }

      it 'should have empty values' do
        expect(instance[:key]).to be nil
      end # it
    end # context

    context 'with set properties' do
      let(:properties) { { :key => :value } }

      it 'should set the values' do
        expect(instance[:key]).to be == :value
      end # it
    end # context
  end # describe

  describe '#[]' do
    it { expect(instance).to respond_to(:[]).with(1).arguments }
  end # describe

  describe '#[]=' do
    it { expect(instance).to respond_to(:[]=).with(2).arguments }

    it 'should change the value' do
      expect {
        instance[:key] = :value
      }.to change {
        instance[:key]
      }.from(nil).to(:value)
    end # it
  end # describe

  describe '#characterize' do
    it { expect(instance).to respond_to(:characterize).with(2..3).arguments }

    let(:rel_name)       { :property }
    let(:rel_properties) { { :key => :value } }

    let(:rel_metadata) { instance.characterize rel_name, rel_properties }

    it 'should create the metadata' do
      expect(rel_metadata).to be_a described_class
    end # it

    it 'should set the value' do
      expect(rel_metadata[:key]).to be == :value
    end # it

    context 'with a type specified' do
      let(:rel_type) do
        Class.new(described_class) do
          def key
            self[:key]
          end # method key
        end # class
      end # let

      let(:rel_metadata) { instance.characterize rel_name, rel_properties, rel_type }

      it 'should create the metadata' do
        expect(rel_metadata).to be_a rel_type
      end # it

      it 'should set the value' do
        expect(rel_metadata.key).to be == :value
      end # it
    end # context
  end # describe

  describe '#concern_key' do
    it { expect(instance).to respond_to(:concern_key).with(0).arguments }
    it { expect(instance.concern_key).to be == name.to_s }

    describe '#[]' do
      let(:value) { "prefix::suffix" }

      it 'should change the value' do
        expect {
          instance[:concern_key] = value
        }.to change(instance, :concern_key).to(value)
      end # it
    end # describe
  end # describe

  describe '#concern_key?' do
    it { expect(instance).to respond_to(:concern_key?).with(0).arguments }
    it { expect(instance.concern_key?).to be false }

    describe '#[]' do
      let(:value) { "prefix::suffix" }

      it 'should change the value' do
        expect {
          instance[:concern_key] = value
        }.to change(instance, :concern_key?).to(true)
      end # it
    end # describe
  end # describe

  describe '#name' do
    it { expect(instance).to respond_to(:name).with(0).arguments }
    it { expect(instance.name).to be == name }
  end # describe

  describe '#properties' do
    it { expect(instance).to respond_to(:properties).with(0).arguments }
    it { expect(instance.properties).to be_a Hash }

    context 'with set properties' do
      let(:properties) { { :key => :value } }

      it 'should set the value' do
        expect(instance.properties).to be == properties
      end # it
    end # context
  end # describe
end # describe
