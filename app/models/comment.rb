class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String#, null: false
  field :book_id, type: Integer
  field :commentable_type, type: String
  field :commentable_id, type: Integer

  belongs_to :book
  belongs_to :commentable, polymorphic: true

  validates :text, presence: true, length: { maximum: 1000 }
  validates :commentable, :book, presence: true

  #paginates_per 40
  #max_paginates_per 40
end
