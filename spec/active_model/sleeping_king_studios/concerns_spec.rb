# spec/active_model/sleeping_king_studios/concerns_spec.rb

require 'active_model/sleeping_king_studios/concerns'

RSpec.describe ActiveModel::SleepingKingStudios::Concerns do
  let(:described_class) { Class.new.extend super() }

  describe '::sleeping_king_studios_concerns' do
    it { expect(described_class).to have_reader(:sleeping_king_studios_concerns).with({}) }
  end # describe
end # describe
