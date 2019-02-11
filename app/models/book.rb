class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps
  # extend FriendlyId

  field :name, type: String
  field :author, type: String
  field :envelope, type: String#, null: false
  field :description, type: String
  field :status, type: Boolean, default: true
  field :likes_count, type: Integer, default: 0

  field :slug, type: String

  embeds_many :likes
  embeds_many :book_histories
  embeds_many :comments

  validates :name, presence: true
  validates :name, uniqueness: true

  # friendly_id :nickname, use: :slugged

  mount_uploader :envelope, EnvelopeUploader
end
