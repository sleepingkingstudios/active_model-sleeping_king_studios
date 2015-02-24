# spec/mappings/mongoid/blog_post.rb

class BlogPost
  include Mongoid::Document

  field :content, :type => String

  belongs_to :blog

  validates :content, :presence => true
end # class
