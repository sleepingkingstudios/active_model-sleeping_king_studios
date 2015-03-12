# spec/active_model/sleeping_king_studios/errors/base_error_spec.rb

require 'active_model/sleeping_king_studios/errors/base_error'

RSpec.describe ActiveModel::SleepingKingStudios::Errors::BaseError do
  let(:problem)  { nil }
  let(:keywords) { {} }
  let(:instance) { described_class.new problem, **keywords }

  describe '::new' do
    it { expect(described_class).to construct.with(0..1, :details, :summary, :resolution) }
  end # describe

  describe '::DEFAULT_PROBLEM' do
    let(:default_problem) { 'An unknown error occurred.' }

    it { expect(described_class::DEFAULT_PROBLEM).to be == default_problem }
  end # describe

  describe '#problem' do
    it { expect(instance).to respond_to(:problem).with(0).arguments }
    it { expect(instance.problem).to be == described_class::DEFAULT_PROBLEM }

    context 'with a value set' do
      let(:problem) { "You must construct additional Pylons." }

      it { expect(instance.problem).to be == problem }
    end # context
  end # describe

  describe '#problem=' do
    let(:value) { "You must construct additional Pylons." }

    it { expect(instance).to respond_to(:problem=).with(1).arguments }
    it 'changes the value' do
      expect {
        instance.problem = value
      }.to change(instance, :problem).to(value)
    end # it
  end # describe

  describe '#summary' do
    it { expect(instance).to respond_to(:summary).with(0).arguments }
    it { expect(instance.summary).to be nil }

    context 'with a value set' do
      let(:value) { "Pylons provide Supply, which allows you to produce more units." }
      let(:keywords) { super().merge :summary => value }

      it { expect(instance.summary).to be == value }
    end # context
  end # describe

  describe '#summary=' do
    let(:value) { "Pylons provide Supply, which allows you to produce more units." }

    it { expect(instance).to respond_to(:summary=).with(1).arguments }
    it 'changes the value' do
      expect {
        instance.summary = value
      }.to change(instance, :summary).to(value)
    end # it
  end # describe

  describe '#details' do
    it { expect(instance).to respond_to(:details).with(0).arguments }
    it { expect(instance.details).to be nil }

    context 'with a value set' do
      let(:value) { "Each Pylon produces 8 Supply and costs 100 Minerals. Pylons also provide power to nearby structures." }
      let(:keywords) { super().merge :details => value }

      it { expect(instance.details).to be == value }
    end # context
  end # describe

  describe '#details=' do
    let(:value) { "Each Pylon produces 8 Supply and costs 100 Minerals. Pylons also provide power to nearby structures." }

    it { expect(instance).to respond_to(:details=).with(1).arguments }
    it 'changes the value' do
      expect {
        instance.details = value
      }.to change(instance, :details).to(value)
    end # it
  end # describe

  describe '#resolution' do
    it { expect(instance).to respond_to(:resolution).with(0).arguments }
    it { expect(instance.resolution).to be nil }

    context 'with a value set' do
      let(:value) { "Select a probe and click Build to bring up the build menu. Click on the pylon, then on a valid location. The probe will begin warping in the structure." }
      let(:keywords) { super().merge :resolution => value }

      it { expect(instance.resolution).to be == value }
    end # context
  end # describe

  describe '#resolution=' do
    let(:value) { "Select a probe and click Build to bring up the build menu. Click on the pylon, then on a valid location. The probe will begin warping in the structure." }

    it { expect(instance).to respond_to(:resolution=).with(1).arguments }
    it 'changes the value' do
      expect {
        instance.resolution = value
      }.to change(instance, :resolution).to(value)
    end # it
  end # describe

  describe '#message' do
    let(:default_problem) { described_class::DEFAULT_PROBLEM }

    it { expect(instance).to respond_to(:message).with(0).arguments }
    it 'prints the default message' do
      expect(instance.message).to be == "Problem:\n  #{default_problem}"
    end # it

    context 'with a problem message' do
      let(:problem) { "We require more minerals." }

      it 'prints the problem message' do
        expect(instance.message).to be == "Problem:\n  #{problem}"
      end # it
    end # context

    context 'with a summary, details, and resolution' do
      let(:summary)    { "The issue likely originates with your computer's chair-to-keyboard interface." }
      let(:details)    { "The operation failed with an error code of ID 10-T." }
      let(:resolution) { "Have you tried turning it off and on again?" }
      let(:keywords) do
        { :summary => summary,
          :details => details,
          :resolution => resolution
        } # end object
      end # let
      let(:message) do
        str = "Problem:\n  #{default_problem}"
        str += "\nSummary:\n  #{summary}"
        str += "\nDetails:\n  #{details}"
        str += "\nResolution:\n  #{resolution}"
      end # let

      it 'prints the message with problem, summary, and resolution' do
        expect(instance.message).to be == message
      end # it
    end # context
  end # describe

  describe 'with a custom subclass' do
    let(:problem)    { "You must spawn more Overlords." }
    let(:summary)    { "Overlords provide Supply, which allows you to produce more units." }
    let(:details)    { "Each Overlord produces 8 Supply and costs 100 Minerals. Overlords also reveal cloaked units." }
    let(:resolution) { "Select your Hatchery and click Larva, then click the Overlord. A new Overlord will begin to spawn from the selected larva." }

    let(:message) do
      str = "Problem:\n  #{problem}"
      str += "\nSummary:\n  #{summary}"
      str += "\nDetails:\n  #{details}"
      str += "\nResolution:\n  #{resolution}"
    end # let

    let(:described_class) do
      klass = Class.new(super()) do
        def initialize; super(); end
      end # let
      klass.class_eval <<-RUBY
        def problem
          "#{problem}"
        end # method problem

        def summary
          "#{summary}"
        end # method summary

        def details
          "#{details}"
        end # method details

        def resolution
          "#{resolution}"
        end # method resolution
      RUBY
      klass
    end # let

    let(:instance) { described_class.new }

    describe '#message' do
      it { expect(instance.message).to be == message }
    end # describe
  end # describe
end # describe
