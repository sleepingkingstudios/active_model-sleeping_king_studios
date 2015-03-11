# lib/active_model/sleeping_king_studios/validations/relations/serializers/underscore_serializer.rb

require 'active_model/sleeping_king_studios/validations/relations/serializers'

module ActiveModel::SleepingKingStudios::Validations::Relations::Serializers
  # Generates underscore-delineated compound keys.
  #
  # @example
  #   UnderscoreSerializer.serialize :soldiers, 0, :rations, 2
  #   #=> :soldiers_0_rations_2
  module UnderscoreSerializer
    extend self

    # Breaks apart a compound key into its constituent keys.
    #
    # @param key [Symbol] The compound key to break apart.
    #
    # @return [Array] The constituent keys.
    def deserialize key
      key.to_s.split('_')
    end # method deserialize

    # Generates a compound key from an array of components.
    #
    # @param keys [Array] The constituent keys to generate a compound key with.
    #
    # @return [Symbol] The compound key.
    def serialize *keys
      keys.join('_').intern
    end # method serialize
  end # module
end # module
