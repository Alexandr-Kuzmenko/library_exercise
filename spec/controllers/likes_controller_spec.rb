require 'rails_helper'

class LikesControllerTest < ActionController::TestCase
  RSpec.describe LikesController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:book) { FactoryBot.create(:book) }
    let(:like) { FactoryBot.create(:like) }
    let(:user) { FactoryBot.create(:user) }

    def random_like_create
      post :create, params: { like: { user_id: user.id }, book_id: book.id }, format: :json
    end

    describe '#create' do
      it 'when logged out' do
        expect(random_like_create).to have_http_status 401
      end

      it 'redirect after create' do
        from users_path
        sign_in user
        random_like_create
        expect(response).to redirect_to users_path
      end

      it 'db records increase after create' do
        sign_in user
        random_like_create
        expect(Book.first.likes.count).to_not eq 0
      end
    end

    describe '#destroy' do
      subject do
        sign_in user
        random_like_create
      end

      it 'when no param :id' do
        expect { delete :destroy, params: {} }.to raise_error
      end

      it 'when logged out' do
        subject
        lk = Book.first.likes.first
        sign_out user
        delete :destroy, params: { id: lk.id, book_id: lk.book.id }
        expect(response).to have_http_status 401
      end

      it 'redirect after destroy (referer - nil)' do
        subject
        lk = Book.first.likes.first
        delete :destroy, params: { id: lk.id, book_id: lk.book.id }, format: :json
        expect(response).to redirect_to books_path
      end

      it 'db record successful delete' do
        subject
        lk = Book.first.likes.first
        delete :destroy, params: { id: lk.id, book_id: lk.book.id }, format: :json
        expect(Book.first.likes.count).to eq 0
      end

      it 'like delete 2' do
        like
        sign_in User.first
        lk = Book.first.likes.first
        delete :destroy, params: { id: lk.id, book_id: lk.book.id }, format: :json
        expect(Book.first.likes.count).to eq 0
      end
    end
  end
end
