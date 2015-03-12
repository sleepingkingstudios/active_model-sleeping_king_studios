# lib/active_model/sleeping_king_studios/errors/invalid_options_error.rb

require 'active_model/sleeping_king_studios/errors/base_error'

module ActiveModel::SleepingKingStudios::Errors
  class InvalidOptionsError < BaseError
    def initialize option, receiver: nil, valid_options: []
      @option        = option
      @receiver      = receiver
      @valid_options = valid_options

      problem = "Invalid option #{option.inspect}#{receiver ? " provided to #{receiver}" : ''}."

      super(problem)
    end # constructor

    attr_reader :option, :receiver, :valid_options

    def summary
      @summary ||= 'ActiveModel::SleepingKingStudios checks the options that '\
        'are passed to the concern macros and certain other operations to '\
        'ensure that no ill side effects occur by letting something slip by.'
    end # method summary

    def resolution
      return @resolution if @resolution

      receiver_string = receiver ? " for #{receiver}" : ''

      return @resolution = "Check the documentation for a list of valid options#{receiver_string}." if @valid_options.blank?

      options_list = case valid_options.count
      when 1
        valid_options[0]
      when 2
        "#{valid_options[0]} and #{valid_options[1]}"
      else
        "#{valid_options[0...-1].join ', '}, and #{valid_options[-1]}"
      end # case

      @resolution = "The valid options#{receiver_string} are: #{options_list}"\
        ". Check the documentation for more information."
    end # method resolution
  end # class
end # class
