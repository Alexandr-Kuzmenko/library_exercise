require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:user_registers) { 3.times { FactoryBot.create(:register, user: user) } }

  describe 'basic mongoid checks' do
    it 'class - mongoid document' do
      is_expected.to be_mongoid_document
    end

    it 'class - have timestamps' do
      is_expected.to have_timestamps
    end
  end

  describe 'associations' do
    it 'association - registers' do
      expect(user).to respond_to :registers
    end

    it 'association type - registers' do
      expect(User.reflect_on_association(:registers).macro).to eq :has_many
    end

    it 'has avatar' do
      expect(user).to respond_to :avatar
    end
  end

  describe 'dependent nullify' do
    it 'successful registers nullify' do
      user_registers
      register_last = Register.last
      User.find(register_last.user.id).destroy
      expect(Register.last.user).to be_nil
    end
  end

  describe 'validations' do
    it 'email presence' do
      expect(build(:user, email: nil)).to_not be_valid
    end

    it 'email uniqueness' do
      expect(build(:user, email: user.email)).to_not be_valid
    end

    it 'invalid password length (not within [6..20])' do
      expect(build(:user, password: '12345')).to_not be_valid
      expect(build(:user, password: '123456789012345678901')).to_not be_valid
      expect(build(:user, password: nil)).to_not be_valid
    end

    it 'valid password length (within [6..20])' do
      expect(build(:user, password: '123336')).to be_valid
      expect(build(:user, password: '12asghjklhr9254yuy3')).to be_valid
    end

    it 'nickname uniqueness' do
      expect(build(:user, nickname: user.nickname)).to_not be_valid
    end

    it 'invalid nickname length (not within [1..20])' do
      expect(build(:user, nickname: 'qwerty_qwerty_qwerty1')).to_not be_valid
    end

    it 'valid nickname length (within [1..20])' do
      expect(build(:user, nickname: 'qop')).to be_valid
      expect(build(:user, nickname: 'qwerty_qwerty_qwerty')).to be_valid
    end
  end
end
