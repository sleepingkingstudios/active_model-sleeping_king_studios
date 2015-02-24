# lib/active_model/sleeping_king_studios/validations/relations/many.rb

require 'active_model/sleeping_king_studios/validations/relations/base'

module ActiveModel::SleepingKingStudios::Validations::Relations
  # The base validator for validating a one-to-many relation.
  class Many < ActiveModel::SleepingKingStudios::Validations::Relations::Base
    # Checks the validity of the related models and merges any errors into the
    # primary model's #errors object.
    #
    # @param record [Object] An object extending ActiveModel::Validations and
    #   with the specified relation.
    def validate record
      record.send(relation_name).each.with_index do |relation, index|
        next if relation.errors.blank? && relation.valid?

        relation.errors.each do |attribute, message|
          record.errors.add error_key(relation, index, attribute), message
        end # each
      end # each
    end # method validate

    private

    def error_key relation, index, attribute
      serializer.serialize relation_name, index, *serializer.deserialize(attribute)
    end # method relation_key

    def relation_name
      :relations
    end # method relation_name
  end # class
end # module
