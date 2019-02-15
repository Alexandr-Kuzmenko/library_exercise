class Book
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Timestamps
  # extend FriendlyId

  # facade
  field :name, type: String
  field :author, type: String
  field :envelope, type: String
  field :description, type: String

  # inner fields
  field :slug, type: String

  field :likes_count, type: Integer, default: 0

  field :status, type: Boolean, default: true
  has_many :registers

  embeds_many :likes
  embeds_many :comments

  validates :name, presence: true
  validates :name, uniqueness: true

  # friendly_id :nickname, use: :slugged

  mount_uploader :envelope, EnvelopeUploader
end
