# spec/support/models/node.rb

class Node
  include ActiveModel::Validations

  attr_writer :relations

  def relations
    @relations ||= []
  end # method relations
end # class
