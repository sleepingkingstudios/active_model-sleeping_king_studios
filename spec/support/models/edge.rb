# spec/support/models/edge.rb

class Edge < Struct.new(:color)
  include ActiveModel::Validations

  validates :color, :presence => true
end # class
