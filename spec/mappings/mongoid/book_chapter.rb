# spec/mappings/mongoid/book_chapter.rb

class BookChapter
  include Mongoid::Document

  field :content, :type => String

  embedded_in :book

  validates :content, :presence => true
end # class
