# spec/support/models/rocket.rb

require 'active_model'

class Rocket
  include ActiveModel::Model

  attr_accessor :fins, :liquid_fuel, :oxidizer

  validates :fins,        :presence => true
  validates :liquid_fuel, :presence => true, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to =>  90.0 }
  validates :oxidizer,    :presence => true, :numericality => { :greater_than_or_equal_to => 0.0, :less_than_or_equal_to => 110.0 }
end # class
