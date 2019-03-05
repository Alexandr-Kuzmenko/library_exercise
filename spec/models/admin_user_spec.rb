require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  let(:admin) { FactoryBot.create(:admin_user) }
  # let(:admin_comments) { 3.times { FactoryBot.create(:comment, commentator: admin.class, commentator_id: admin.id) } }

  describe 'basic mongoid checks' do
    it 'class - mongoid document' do
      is_expected.to be_mongoid_document
    end

    it 'class - have timestamps' do
      is_expected.to have_timestamps
    end
  end

  describe 'associations' do
    it 'has avatar' do
      expect(admin).to respond_to :avatar
    end
  end

  describe 'validations' do
    it 'email presence' do
      expect(build(:admin_user, email: nil)).to_not be_valid
    end

    it 'email uniqueness' do
      expect(build(:admin_user, email: admin.email)).to_not be_valid
    end

    it 'nickname uniqueness' do
      expect(build(:admin_user, nickname: admin.nickname)).to_not be_valid
    end

    it 'invalid password length (not within [6..20])' do
      expect(build(:admin_user, password: '12345')).to_not be_valid
      expect(build(:admin_user, password: '123456789012345678901')).to_not be_valid
      expect(build(:admin_user, password: nil)).to_not be_valid
    end

    it 'valid password length (within [6..20])' do
      expect(build(:admin_user, password: '123456')).to be_valid
      expect(build(:admin_user, password: '123456assghr9254yuy3')).to be_valid
    end
  end

  describe 'methods' do
    it '#password_required? option 1' do
      expect(AdminUser.new.password_required?).to eq false
    end

    it '#password_required? option 2' do
      expect(admin.password_required?).to eq true
    end
  end
end
