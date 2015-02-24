# spec/support/models/soldier.rb

require 'active_model/sleeping_king_studios/validations/relations'

class Soldier < Struct.new(:rank)
  include ActiveModel::Validations
  include ActiveModel::SleepingKingStudios::Validations::Relations

  attr_accessor :army

  def rations
    @rations ||= []
  end # method rations

  attr_writer :rations

  validates :rank, :presence => true
  validates_related_records :rations
end # class
