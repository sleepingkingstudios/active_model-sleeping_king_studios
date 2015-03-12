# lib/active_model/sleeping_king_studios/concern/metadata.rb

require 'active_model/sleeping_king_studios/concerns'

module ActiveModel::SleepingKingStudios
  module Concern
    # Stores information about a given concern. Concerns may subclass Metadata
    # to add further keys and/or functionality.
    class Metadata < Hash
      # @param [Symbol, String] name The name of the concern or relation.
      # @param [Hash] properties The properties of the concern or relation.
      def initialize name, properties = {}
        @name       = name
        @properties = properties.dup

        merge! properties if Hash === properties
      end # constructor

      # @return [Symbol] The name of the concern or relation.
      attr_reader :name

      # @return [Hash] The unmodified properties hash that was passed into the
      #   constructor.
      attr_reader :properties

      # @overload characterize name, properties, type = Metadata
      #   Creates a metadata instance for a subgroup of the metadata, such as a
      #   generated concern or for an optional parameter.
      #
      #   @param [Symbol] name The name of the concern. Must be unique for the
      #     base type within the sleeping_king_studios_concerns namespace.
      #   @param [Hash] properties The options for the concern.
      #   @param [Class] type The type of the generated metadata.
      #
      #   @return [Metadata] The generated metadata.
      def characterize name, properties, type = nil
        type ||= ActiveModel::SleepingKingStudios::Concern::Metadata
        type.new name, properties
      end # method characterize

      # The key used to store the metadata, if applicable.
      #
      # @return [String] The key used to store the metadata.
      def concern_key
        self[:concern_key] || name.to_s
      end # method concern_key

      # @return [Boolean] True if a custom concern key is defined, otherwise
      #   false.
      def concern_key?
        !!self[:concern_key]
      end # method concern_key?
    end # class
  end # module
end # module
