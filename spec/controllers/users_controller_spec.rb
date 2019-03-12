require 'rails_helper'

class UsersControllerTest < ActionController::TestCase
  RSpec.describe UsersController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:user) { FactoryBot.create(:user) }

    describe '#edit' do
      it 'when logged out' do
        get :edit, params: { id: user.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#update' do
      it 'when logged out' do
        patch :update, params: { id: user.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'redirect after update' do
        sign_in user
        patch :update, params: { user: { nickname: 'unique nick11!!!' }, id: user.id }
        expect(response).to redirect_to users_path
      end

      it 'db record have changed' do
        sign_in user
        old_nick = user.nickname
        patch :update, params: { user: { nickname: 'Some new nick' }, id: user.id }
        expect(User.find_by(nickname: old_nick)).to be_nil
      end
    end

    describe '#destroy' do
      it 'when no param :id' do
        expect { delete :destroy, params: {} }.to raise_error
      end

      it 'when logged out' do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'destroy & redirect' do
        sign_in user
        id = user.id
        expect(User.find(id: id)).to_not be_nil
        delete :destroy, params: { id: id }
        expect(User.find(id: id)).to be_nil
        expect(response).to redirect_to root_path
      end
    end
  end
end
