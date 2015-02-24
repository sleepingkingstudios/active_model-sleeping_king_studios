# lib/active_model/sleeping_king_studios/validations/relations/base.rb

require 'active_model/sleeping_king_studios/validations/relations'
require 'active_model/sleeping_king_studios/validations/relations/serializers/bracket_serializer'
require 'active_model/validator'

module ActiveModel::SleepingKingStudios::Validations::Relations
  # Base class for relation validators.
  class Base < ActiveModel::Validator
    # The serializer object used to generate compound error keys. Must respond
    # to #serialize and #deserialize.
    #
    # @see Serializers
    def serializer
      ActiveModel::SleepingKingStudios::Validations::Relations::Serializers::BracketSerializer
    end # method serializer
  end # class
end # module
