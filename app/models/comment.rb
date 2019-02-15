class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String#, null: false
  field :commentator, type: String
  field :commentator_id, type: String

  embedded_in :book

  validates :text, presence: true, length: { maximum: 1000 }
  validates :commentator, :commentator_id, :book, presence: true

  # paginates_per 40
  # max_paginates_per 40
end
