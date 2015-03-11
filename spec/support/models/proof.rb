# spec/support/models/proof.rb

class Proof < Struct.new(:correct)
  include ActiveModel::Validations

  validates :correct, :inclusion => { :in => [true, false] }
end # class
