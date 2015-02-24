# spec/support/models/rations.rb

require 'active_support/core_ext'

class Rations < Struct.new(:expires_on)
  class FreshValidator < ActiveModel::EachValidator
    def validate_each record, attribute, value
      record.errors.add :base, 'is spoiled' if value < Time.current
    end # method record
  end # class

  include ActiveModel::Validations

  attr_accessor :soldier

  validates :expires_on, :fresh => { :unless => ->(record) { record.expires_on.nil? } }
end # class
