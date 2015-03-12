# spec/active_model/sleeping_king_studios/errors/invalid_options_error_spec.rb

require 'active_model/sleeping_king_studios/errors/invalid_options_error'

RSpec.describe ActiveModel::SleepingKingStudios::Errors::InvalidOptionsError do
  describe '::new' do
    it { expect(described_class).to construct.with(1, :receiver, :valid_options).arguments }
  end # describe

  let(:option)        { :defenestrate }
  let(:receiver)      { nil }
  let(:valid_options) { nil }
  let(:instance)      { described_class.new option, :receiver => receiver, :valid_options => valid_options }

  describe '#option' do
    it { expect(instance).to have_reader(:option).with_value(option) }
  end # describe

  describe '#receiver' do
    it { expect(instance).to have_reader(:receiver).with_value(receiver) }

    context 'with a named receiver' do
      let(:receiver) { 'Receiver::i_hardly_knew_her' }

      it { expect(instance.receiver).to be == receiver }
    end # context
  end # describe

  describe '#valid_options' do
    it { expect(instance).to have_reader(:valid_options).with_value(valid_options) }

    context 'with a list of valid options' do
      let(:valid_options) { %i(name quest favorite_color) }

      it { expect(instance.valid_options).to be == valid_options }
    end # describe
  end # describe

  describe '#problem' do
    it { expect(instance).to have_reader(:problem).with_value("Invalid option #{option.inspect}.") }

    context 'with a named receiver' do
      let(:receiver) { 'Receiver::i_hardly_knew_her' }

      it { expect(instance.problem).to be == "Invalid option #{option.inspect} provided to #{receiver}." }
    end # context
  end # describe

  describe '#summary' do
    let(:expected) do
      'ActiveModel::SleepingKingStudios checks the options that are passed to'\
      ' the concern macros and certain other operations to ensure that no ill'\
      ' side effects occur by letting something slip by.'
    end

    it { expect(instance).to have_reader(:summary).with_value(expected) }
  end # describe

  describe '#resolution' do
    let(:expected) { 'Check the documentation for a list of valid options.' }

    it { expect(instance).to have_reader(:resolution).with_value(expected) }

    context 'with a named receiver' do
      let(:receiver) { 'Receiver::i_hardly_knew_her' }
      let(:expected) { "Check the documentation for a list of valid options for #{receiver}." }

      it { expect(instance).to have_reader(:resolution).with_value(expected) }
    end # context

    describe 'with a list of valid options' do
      let(:receiver_string) { receiver.blank? ? '' : " for #{receiver}" }
      let(:plural_string)   { "" }
      let(:expected) do
        "The valid options#{receiver_string} are: #{options_list}. Check the "\
        "documentation for more information."
      end

      context 'with no items' do
        let(:valid_options) { [] }
        let(:expected)      { "Check the documentation for a list of valid options." }

        it { expect(instance).to have_reader(:resolution).with_value(expected) }

        context 'with a named receiver' do
          let(:receiver) { 'Receiver::i_hardly_knew_her' }
          let(:expected) { "Check the documentation for a list of valid options for #{receiver}." }

          it { expect(instance).to have_reader(:resolution).with_value(expected) }
        end # context
      end # context

      context 'with one item' do
        let(:valid_options) { %i(name) }
        let(:options_list)  { valid_options[0] }

        it { expect(instance).to have_reader(:resolution).with_value(expected) }

        context 'with a named receiver' do
          let(:receiver) { 'Receiver::i_hardly_knew_her' }

          it { expect(instance).to have_reader(:resolution).with_value(expected) }
        end # context
      end # context

      context 'with two items' do
        let(:valid_options) { %i(name quest) }
        let(:options_list)  { "#{valid_options[0]} and #{valid_options[1]}" }

        it { expect(instance).to have_reader(:resolution).with_value(expected) }

        context 'with a named receiver' do
          let(:receiver) { 'Receiver::i_hardly_knew_her' }

          it { expect(instance).to have_reader(:resolution).with_value(expected) }
        end # context
      end # context

      context 'with many items' do
        let(:valid_options) { %i(name quest favorite_color) }
        let(:options_list)  { "#{valid_options[0...-1].join(', ')}, and #{valid_options.last}" }

        it { expect(instance).to have_reader(:resolution).with_value(expected) }

        context 'with a named receiver' do
          let(:receiver) { 'Receiver::i_hardly_knew_her' }

          it { expect(instance).to have_reader(:resolution).with_value(expected) }
        end # context
      end # context
    end # context
  end # describe

  describe '#message' do
    let(:expected) do
      "Problem:\n  #{instance.problem}\nSummary:\n  #{instance.summary}\n"\
        "Resolution:\n  #{instance.resolution}"
    end # let

    it { expect(instance).to have_reader(:message).with_value(expected) }

    context 'with a named receiver' do
      let(:receiver) { 'Receiver::i_hardly_knew_her' }

      it { expect(instance).to have_reader(:message).with_value(expected) }
    end # context

    context 'with a list of valid options' do
      let(:valid_options) { %i(name quest favorite_color) }

      it { expect(instance).to have_reader(:message).with_value(expected) }

      context 'with a named receiver' do
        let(:receiver) { 'Receiver::i_hardly_knew_her' }

        it { expect(instance).to have_reader(:message).with_value(expected) }
      end # context
    end # describe
  end # describe
end # describe
