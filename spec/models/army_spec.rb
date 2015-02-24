# spec/models/army_spec.rb

require 'spec_helper'

require 'support/models/army'

RSpec.describe Army do
  shared_examples 'should merge the relation errors into errors' do
    it 'should merge the relation errors into errors' do
      instance.valid?

      expect(instance.errors.keys).to contain_exactly *errors.keys
      errors.each do |key, messages|
        expect(instance.errors[key]).to contain_exactly *messages
      end # each
    end # it
  end # shared_examples

  let(:instance) { described_class.new }

  ### Validation ###
  it { expect(instance).to be_valid }

  describe 'with a valid general' do
    let!(:general) { instance.general = General.new('Croix de Guerre') }

    it { expect(instance).to be_valid }
  end # describe

  describe 'with an invalid general' do
    let!(:general) { instance.general = General.new }
    let(:errors) do
      { :"general[medals]" => ["can't be blank"] }
    end # let

    it { expect(instance).not_to be_valid }

    include_examples 'should merge the relation errors into errors'
  end # describe

  describe 'with many valid soldiers' do
    let!(:soldiers) { instance.soldiers = %w(private private leftenant).map { |rank| Soldier.new(rank) } }

    it { expect(instance).to be_valid }

    describe 'with many valid rations' do
      let!(:rations) { soldiers.map { |soldier| soldier.rations = Array.new(3) { Rations.new } } }

      it { expect(instance).to be_valid }
    end # describe

    describe 'with many invalid rations' do
      let!(:rations) { soldiers.map { |soldier| soldier.rations = Array.new(3) { Rations.new(7.days.ago) } } }
      let(:errors) do
        soldiers.each.with_index.with_object({}) do |(soldier, index), hsh|
          soldier.rations.each.with_index do |rations, rindex|
            hsh[:"soldiers[#{index}][rations][#{rindex}][base]"] = ['is spoiled']
          end # each
        end # each
      end # let

      it { expect(instance).not_to be_valid }

      include_examples 'should merge the relation errors into errors'
    end # describe
  end # describe

  describe 'with many invalid soldiers' do
    let!(:soldiers) { instance.soldiers = Array.new(3) { Soldier.new } }
    let(:errors) do
      soldiers.each.with_index.with_object({}) do |(_, index), hsh|
        hsh[:"soldiers[#{index}][rank]"] = ["can't be blank"]
      end # each
    end # let

    it { expect(instance).not_to be_valid }

    include_examples 'should merge the relation errors into errors'

    describe 'with many invalid rations' do
      let!(:rations) { soldiers.map { |soldier| soldier.rations = Array.new(3) { Rations.new(7.days.ago) } } }
      let(:errors) do
        soldiers.each.with_index.with_object({}) do |(soldier, index), hsh|
          hsh[:"soldiers[#{index}][rank]"] = ["can't be blank"]

          soldier.rations.each.with_index do |rations, rindex|
            hsh[:"soldiers[#{index}][rations][#{rindex}][base]"] = ['is spoiled']
          end # each
        end # each
      end # let

      it { expect(instance).not_to be_valid }

      include_examples 'should merge the relation errors into errors'
    end # describe
  end # describe
end # describe
