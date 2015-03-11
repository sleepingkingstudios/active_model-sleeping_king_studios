# lib/active_model/sleeping_king_studios/validations/relations/serializers/bracket_serializer.rb

require 'active_model/sleeping_king_studios/validations/relations/serializers'

module ActiveModel::SleepingKingStudios::Validations::Relations::Serializers
  # Generates bracket-delineated compound keys.
  #
  # @example
  #   BracketSerializer.serialize :soldiers, 0, :rations, 2
  #   #=> :"soldiers[0][rations][2]"
  module BracketSerializer
    extend self

    # Breaks apart a compound key into its constituent keys.
    #
    # @param key [Symbol] The compound key to break apart.
    #
    # @return [Array] The constituent keys.
    def deserialize key
      key.to_s.sub(/\]\z/, '').split(/\]?\[/)
    end # method deserialize

    # Generates a compound key from an array of components.
    #
    # @param keys [Array] The constituent keys to generate a compound key with.
    #
    # @return [Symbol] The compound key.
    def serialize *keys
      keys[1..-1].inject(keys.first.to_s) { |str, key| str << '[' << key.to_s << ']' }.intern
    end # method serialize
  end # module
end
