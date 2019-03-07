require 'rails_helper'

class RegistersControllerTest < ActionController::TestCase
  RSpec.describe RegistersController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:admin) { FactoryBot.create(:admin) }
    let(:book) { FactoryBot.create(:book) }
    let(:register) { FactoryBot.create(:register) }
    let(:user) { FactoryBot.create(:user) }

    # def random_reg_create
    #   post :create, params: { register: {}, book: book, user: user }
    # end

    describe '#destroy' do
      subject do
        sign_in user
        random_reg_create
      end

      it 'when no param :id' do
        expect { delete :destroy, params: {} }.to raise_error
      end

      it 'when logged out' do
        register
        delete :destroy, params: { id: register.id, book_id: register.book.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      # it 'redirect after destroy (referer - nil)' do
      #   register
      #   sign_in admin
      #   delete :destroy, params: { id: register.id, book_id: register.book.id }
      #   # expect(response).to redirect_to '/'
      # end

      it 'db record successful delete' do
        register
        expect(Register.count).to eq 1
        sign_in admin
        delete :destroy, params: { id: register.id, book_id: register.book.id }
        expect(Register.count).to eq 0
      end
    end
  end
end
