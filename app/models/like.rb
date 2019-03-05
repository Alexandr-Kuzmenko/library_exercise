class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_id, type: String

  embedded_in :book, counter_cache: true

  validates :book, :user_id, presence: true
  validates_uniqueness_of :user_id, scope: :book
end
