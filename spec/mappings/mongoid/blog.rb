# spec/mappings/mongoid/blog.rb

require 'active_model/sleeping_king_studios/validations/relations'

class Blog
  include Mongoid::Document
  include ActiveModel::SleepingKingStudios::Validations::Relations

  belongs_to :author

  has_many :posts, :class_name => 'BlogPost', :validate => false

  validates_related_documents :author
  validates_related_documents :posts
end # class
