# spec/support/models/army.rb

require 'active_model/sleeping_king_studios/validations/relations'

class Army
  include ActiveModel::Validations
  include ActiveModel::SleepingKingStudios::Validations::Relations

  attr_accessor :general

  def soldiers
    @soldiers ||= []
  end # method soldiers

  attr_writer :soldiers

  validates_related_records :general
  validates_related_records :soldiers
end # class
