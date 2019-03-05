require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }

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
      expect(comment).to respond_to :book
    end

    it 'association type - book' do
      expect(Comment.reflect_on_association(:book).macro).to eq :embedded_in
    end

    it 'has commentator_id' do
      expect(comment).to respond_to :commentator_id
      expect(comment.commentator_id).to be_a_kind_of(String)
    end

    it 'has commentator' do
      expect(comment).to respond_to :commentator
      expect(comment.commentator).to be_a_kind_of(String)
    end

    it 'has text' do
      expect(comment).to respond_to :text
    end
  end

  describe 'validations' do
    it 'text presence' do
      expect(build(:comment, text: nil)).to_not be_valid
    end

    it 'commentator presence' do
      expect(build(:comment, commentator: nil)).to_not be_valid
    end

    it 'commentator_id presence' do
      expect(build(:comment, commentator_id: nil)).to_not be_valid
    end

    it 'book presence' do
      expect(build(:comment, book: nil)).to_not be_valid
    end

    it 'invalid text length over 1000 symbols' do
      str = ['a'..'z'].map(&:to_a).flatten
      text = ''
      126.times { text << (0..6).map { str[rand(str.length)] }.join + ' ' }
      expect(build(:comment, text: text)).to_not be_valid
    end

    it 'valid text length up to 1000 symbols' do
      str = ['a'..'z'].map(&:to_a).flatten
      text = ''
      125.times { text << (0..6).map { str[rand(str.length)] }.join + ' ' }
      expect(build(:comment, text: text)).to be_valid
    end
  end
end
