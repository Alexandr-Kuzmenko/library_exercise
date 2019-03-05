require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:book) { FactoryBot.create(:book) }
  let(:like) { FactoryBot.create(:like) }
  let(:user) { FactoryBot.create(:user) }

  describe 'basic mongoid checks' do
    it 'class - mongoid document' do
      is_expected.to be_mongoid_document
    end

    it 'class - have timestamps' do
      is_expected.to have_timestamps
    end
  end

  describe 'associations' do
    it 'association - book' do
      expect(like).to respond_to :book
    end

    it 'association type - book' do
      expect(Like.reflect_on_association(:book).macro).to eq :embedded_in
    end

    it 'has user_id' do
      expect(like).to respond_to :user_id
      expect(like.user_id).to be_a_kind_of(String)
    end
  end

  describe 'validations' do
    it 'user_id presence' do
      expect(build(:like, user_id: nil)).to_not be_valid
    end

    it 'user_id uniqueness on scope book' do
      expect(build(:like, user_id: like.user_id, book: like.book)).to_not be_valid
      expect(build(:like, user_id: like.user_id, book: book)).to be_valid
      expect(build(:like, user_id: user.id, book: like.book)).to be_valid
    end

    it 'book presence' do
      expect(build(:like, book: nil)).to_not be_valid
    end
  end
end
