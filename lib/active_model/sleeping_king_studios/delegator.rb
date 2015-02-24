# lib/active_model/sleeping_king_studios/delegator.rb

require 'active_model/sleeping_king_studios'

module ActiveModel::SleepingKingStudios
  class Delegator < ::Delegator
    def initialize record
      super

      @record = record
    end # constructor

    def record
      @record
    end # method record
    alias_method :__getobj__, :record

    def record= record
      @record = record
    end # method record=
    alias_method :__setobj__, :record=
  end # class
end # class
