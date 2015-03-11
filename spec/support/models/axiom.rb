# spec/support/models/axiom.rb

class Axiom
  include ActiveModel::Validations

  attr_accessor :relation
end # class
