# lib/active_model/sleeping_king_studios/concern.rb

require 'active_model/sleeping_king_studios/concern/metadata'
require 'active_model/sleeping_king_studios/concerns'
require 'active_model/sleeping_king_studios/errors/invalid_options_error'

module ActiveModel::SleepingKingStudios
  # Base module for concerns with shared behavior, such as creating and
  # validating metadata objects from an options hash and storing that metadata
  # on the target class.
  module Concern
    # @api private
    def included base
      super

      unless base.singleton_class.ancestors.include?(ActiveModel::SleepingKingStudios::Concerns)
        base.extend ActiveModel::SleepingKingStudios::Concerns
      end # unless
    end # method included

    # @overload characterize name, properties, type = Metadata
    #   Creates a metadata instance for the concern.
    #
    #   @param [Symbol] name The name of the concern. Must be unique for the
    #     base type within the sleeping_king_studios namespace.
    #   @param [Hash] options The options for the concern.
    #   @param [Class] type The type of the generated metadata.
    #
    #   @return [Metadata] The generated metadata.
    def characterize name, options, type = nil
      type ||= ActiveModel::SleepingKingStudios::Concern::Metadata
      type.new name, options
    end # method characterize

    # Stores the metadata in the class's sleeping_king_studios_concerns object
    # using the metadata#relation_key as the key.
    #
    # @param [Class] base The base class into which the concern is mixed in.
    # @param [Symbol] name The name of the concern. Must be unique for the
    #   base type within the sleeping_king_studios namespace.
    # @param [Metadata] metadata The metadata to be stored.
    def relate base, name, metadata
      base.sleeping_king_studios_concerns[metadata.concern_key] = metadata
    end # method relate

    # Returns a list of options that are valid for this concern.
    #
    # @return [Array<Symbol>] The list of valid options.
    def valid_options
      %i()
    end # method valid_options

    # Evaluates the provided options and raises an error if any of the options
    # are invalid, based on the list from #valid_options.
    #
    # @param [Symbol] name The name of the relation.
    # @param [Hash] options The options for the relation.
    #
    # @raise [ActiveModel::SleepingKingStudios::Errors::InvalidOptionsError]
    #   If any of the options provided are invalid.
    def validate_options options, receiver: nil
      options.keys.each do |key|
        if !valid_options.include?(key)
          raise ActiveModel::SleepingKingStudios::Errors::InvalidOptionsError.new(
            key,
            :receiver      => receiver,
            :valid_options => valid_options
          ) # end InvalidOptions
        end # if
      end # each
    end # method validate_options
  end # module
end # module
