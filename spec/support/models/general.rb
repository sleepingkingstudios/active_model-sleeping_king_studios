# spec/support/models/general.rb

class General < Struct.new(:medals)
  include ActiveModel::Validations

  attr_accessor :army

  validates :medals, :presence => true
end # class
