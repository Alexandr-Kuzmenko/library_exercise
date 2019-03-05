require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { FactoryBot.create(:book) }
  let(:book_registers) { 3.times { FactoryBot.create(:register, book: book) } }

  describe 'basic mongoid checks' do
    it 'class - mongoid document' do
      is_expected.to be_mongoid_document
    end

    it 'class - dynamic document' do
      is_expected.to be_dynamic_document
    end

    it 'class - have timestamps' do
      is_expected.to have_timestamps
    end
  end

  describe 'associations' do
    it 'association - registers' do
      expect(book).to respond_to :registers
    end

    it 'association type - registers' do
      expect(Book.reflect_on_association(:registers).macro).to eq :has_many
    end

    it 'association - comments' do
      expect(book).to respond_to :comments
    end

    it 'association type - comments' do
      expect(Book.reflect_on_association(:comments).macro).to eq :embeds_many
    end

    it 'association - likes' do
      expect(book).to respond_to :likes
    end

    it 'association type - likes' do
      expect(Book.reflect_on_association(:likes).macro).to eq :embeds_many
    end

    it 'has envelope' do
      expect(book).to respond_to :envelope
    end

    it 'respond_to status, default - true' do
      expect(book).to respond_to :status
      expect(book.status).to be_truthy
    end

    it 'respond_to likes_count, default 0' do
      expect(book).to respond_to :likes_count
      expect(book.likes_count).to eq 0
    end
  end

  describe 'dependent nullify' do
    it 'successful registers nullify' do
      book_registers
      register_last = Register.last
      Book.find(register_last.book.id).destroy
      expect(Register.last.book).to be_nil
    end
  end

  describe 'validations' do
    it 'name presence' do
      expect(build(:book, name: nil)).to_not be_valid
    end

    it 'name uniqueness' do
      expect(build(:book, name: book.name)).to_not be_valid
    end
  end
end
