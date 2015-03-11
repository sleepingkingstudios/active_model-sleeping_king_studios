# spec/mappings/mongoid/book_preface.rb

class BookPreface
  include Mongoid::Document

  field :content, :type => String

  embedded_in :book

  validates :content, :presence => true
end # class
