require 'rails_helper'

RSpec.describe Register, type: :model do
  let(:register) { FactoryBot.create(:register) }

  describe 'basic mongoid checks' do
    it 'class - mongoid document' do
      is_expected.to be_mongoid_document
    end

    it 'class - have timestamps' do
      is_expected.to have_timestamps
    end
  end

  describe 'associations' do
    it 'association - user' do
      expect(register).to respond_to :user
    end

    it 'association type - categories' do
      expect(Register.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'association - book' do
      expect(register).to respond_to :book
    end

    it 'association type - categories' do
      expect(Register.reflect_on_association(:book).macro).to eq :belongs_to
    end

    it 'respond_to expired, default status - false' do
      expect(register).to respond_to :expired
      expect(register.expired).to be_falsey
    end
  end

  describe 'validations' do
    it 'user presence' do
      expect(build(:register, user: nil)).to_not be_valid
    end

    it 'book presence' do
      expect(build(:register, book: nil)).to_not be_valid
    end

    it 'expired status presence' do
      expect(build(:register, expired: nil)).to_not be_valid
    end
  end
end
