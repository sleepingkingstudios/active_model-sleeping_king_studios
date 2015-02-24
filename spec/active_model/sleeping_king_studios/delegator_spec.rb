# spec/active_model/sleeping_king_studios/delegator_spec.rb

require 'active_model/sleeping_king_studios/delegator'

RSpec.describe ActiveModel::SleepingKingStudios::Delegator do
  include RSpec::SleepingKingStudios::Examples::PropertyExamples

  let(:attributes) { {} }
  let(:record)     { Rocket.new attributes }
  let(:instance)   { described_class.new record }

  include_examples 'has property', :record,      ->() { record }

  include_examples 'has property', :fins,        ->() { attributes[:fins] }

  include_examples 'has property', :liquid_fuel, ->() { attributes[:liquid_fuel] }

  include_examples 'has property', :oxidizer,    ->() { attributes[:oxidizer] }

  ### Validation ###

  it { expect(instance).to respond_to(:valid?).with(0).arguments }

  describe 'fins must be present' do
    let(:attributes) { super().merge :fins => nil }

    it { expect(record).to have_errors.on(:fins).with_message("can't be blank") }
  end # describe

  describe 'liquid_fuel must be present' do
    let(:attributes) { super().merge :liquid_fuel => nil }

    it { expect(record).to have_errors.on(:liquid_fuel).with_message("can't be blank") }
  end

  describe 'liquid_fuel must be numeric' do
    let(:attributes) { super().merge :liquid_fuel => 'empty' }

    it { expect(record).to have_errors.on(:liquid_fuel).with_message("is not a number") }
  end # describe

  describe 'liquid_fuel must be greater than or equal to 0.0' do
    let(:attributes) { super().merge :liquid_fuel => -10.0 }

    it { expect(record).to have_errors.on(:liquid_fuel).with_message("must be greater than or equal to 0.0") }
  end # describe

  describe 'liquid_fuel must be less than or equal to 90.0' do
    let(:attributes) { super().merge :liquid_fuel => 200.0 }

    it { expect(record).to have_errors.on(:liquid_fuel).with_message("must be less than or equal to 90.0") }
  end # describe

  describe 'oxidizer must be present' do
    let(:attributes) { super().merge :oxidizer => nil }

    it { expect(record).to have_errors.on(:oxidizer).with_message("can't be blank") }
  end

  describe 'oxidizer must be numeric' do
    let(:attributes) { super().merge :oxidizer => 'empty' }

    it { expect(record).to have_errors.on(:oxidizer).with_message("is not a number") }
  end # describe

  describe 'oxidizer must be greater than or equal to 0.0' do
    let(:attributes) { super().merge :oxidizer => -10.0 }

    it { expect(record).to have_errors.on(:oxidizer).with_message("must be greater than or equal to 0.0") }
  end # describe

  describe 'oxidizer must be less than or equal to 110.0' do
    let(:attributes) { super().merge :oxidizer => 200.0 }

    it { expect(record).to have_errors.on(:oxidizer).with_message("must be less than or equal to 110.0") }
  end # describe
end # describe
