# lib/active_model/sleeping_king_studios/validations/relations/one.rb

require 'active_model/sleeping_king_studios/validations/relations/base'

module ActiveModel::SleepingKingStudios::Validations::Relations
  # The base validator for validating a one-to-one relation.
  class One < ActiveModel::SleepingKingStudios::Validations::Relations::Base
    # Checks the validity of the related model and merges any errors into the
    # primary model's #errors object.
    #
    # @param record [Object] An object extending ActiveModel::Validations and
    #   with the specified relation.
    def validate record
      relation = record.send(relation_name)

      return if relation.blank? || (relation.errors.blank? && relation.valid?)

      relation.errors.each do |attribute, message|
        record.errors.add error_key(relation, attribute), message
      end # each
    end # method validate

    private

    def error_key relation, attribute
      serializer.serialize relation_name, *serializer.deserialize(attribute)
    end # method relation_key

    def relation_name
      :relation
    end # method relation_name
  end # class
end # module
