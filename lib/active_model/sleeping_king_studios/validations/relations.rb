# lib/active_model/sleeping_king_studios/validations/relations.rb

require 'active_support'
require 'active_support/core_ext'
require 'active_model/sleeping_king_studios/validations'

module ActiveModel::SleepingKingStudios::Validations
  # Concerns and support classes for validating related models.
  module Relations
    extend ActiveSupport::Concern

    # Extends model classes with methods for validating related models.
    module ClassMethods
      # Configures model class to perform advanced processing on error messages
      # from nested resources when generating full error messages.
      def parse_relation_error_messages options = {}
        serializer = ActiveModel::SleepingKingStudios::Validations::Relations::Serializers::BracketSerializer

        class_methods = Module.new
        class_methods.send :define_method, :human_attribute_name do |attribute, opts = {}|
          return super(attribute, opts) unless attribute =~ /\[(\w*)\]/

          serializer = ActiveModel::SleepingKingStudios::Validations::Relations::Serializers::BracketSerializer

          ary      = []
          segments = serializer.deserialize(attribute)

          index = 0
          while index < segments.count
            indices = []
            segment = segments[index]

            index += 1 and next if segment == 'base'

            next_segment = segments[index + 1]
            while !next_segment.blank? && next_segment =~ /\A\d+\z/
              indices << next_segment

              index += 1
              next_segment = segments[index + 1]
            end # while

            if indices.count > 0
              ary << "#{super(segment).downcase.singularize << ' ' << indices.join(' ')}"
            else
              ary << super(segment).downcase
            end # if-else

            index += 1
          end # while

          ary.first.capitalize!
          ary.join("'s ")
        end # define_method

        extend class_methods
      end # class method parse_relation_error_messages

      # Configures model class to validate the specified relation and to fold
      # in error messages from failing relations to the primary model's #errors
      # instance.
      #
      # @param relation_name [Symbol, String] The relation to validate. When
      #   calling model.send(relation_name), must return an Enumerable which
      #   lists each model in the relation to validate, such as an ActiveRecord
      #   association or a Mongoid relation.
      # @param options [Hash] Additional configuration options.
      #
      # @option options arity [Symbol] Set whether the relation is a one-to-one
      #   relation (e.g. :belongs_to, :has_one, :embedded_in, or :embeds_one)
      #   or a one-to-many relation (e.g. :has_many, :embeds_many). If this
      #   option is not given, the code will attempt to guess based on the name
      #   of the relation.
      # @option options serializer [Class] A serializer object to use when
      #   generating compound error keys.
      #
      # @see Serializers
      def validates_related_records relation_name, options = {}
        ActiveModel::SleepingKingStudios::Validations::Relations.apply self, relation_name, options
      end # class method validates_related_records
      alias_method :validates_related_documents, :validates_related_records
    end # module

    class << self
      # @api private
      #
      # Sets up the validation of the specified relation on the given model
      # class.
      #
      # @see ClassMethods#validates_related_records
      def apply base, relation_name, options
        arity = options[:arity] || guess_arity(relation_name)

        # We lazily require the One and Many validator classes here to avoid
        # dependency loops.
        case arity.intern
        when :one
          require 'active_model/sleeping_king_studios/validations/relations/one' unless defined?(ActiveModel::SleepingKingStudios::Validations::Relations::One)

          validator_base = ActiveModel::SleepingKingStudios::Validations::Relations::One
        when :many
          require 'active_model/sleeping_king_studios/validations/relations/many' unless defined?(ActiveModel::SleepingKingStudios::Validations::Relations::Many)

          validator_base = ActiveModel::SleepingKingStudios::Validations::Relations::Many
        else
          raise ArgumentError.new "unrecognized arity value #{arity} -- must be :one or :many"
        end # case

        validator_class = Class.new(validator_base) do
          define_method :relation_name do
            relation_name
          end # method relation_name

          if options[:serializer].respond_to?(:serialize)
            define_method :serializer do
              options[:serializer]
            end # method serializer
          end # if
        end # class

        base.send :validates_with, validator_class
      end # module method apply

      private

      def guess_arity relation_name
        relation_name.to_s == relation_name.to_s.singularize ?
          :one :
          :many
      end # module method guess_arity
    end # eigenclass
  end # module
end # module
