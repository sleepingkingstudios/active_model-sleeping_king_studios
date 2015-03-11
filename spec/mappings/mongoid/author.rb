# spec/mappings/mongoid/author.rb

class Author
  include Mongoid::Document

  field :name, :type => String

  has_many :blogs, :validate => false

  validates :name, :presence => true
end # class
