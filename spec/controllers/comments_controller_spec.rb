require 'rails_helper'

class CommentsControllerTest < ActionController::TestCase
  RSpec.describe CommentsController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:admin) { FactoryBot.create(:admin) }
    let(:book) { FactoryBot.create(:book) }
    let(:comment) { FactoryBot.create(:comment) }
    let(:admin_comment) { FactoryBot.create(:admin_comment) }
    let(:user) { FactoryBot.create(:user) }

    def random_comm_create
      post :create, params: { comment: { text: Faker::Games::WorldOfWarcraft.quote, commentator: user.class,
                                         commentator_id: user.id }, book_id: book.id }
    end

    describe '#new' do
      it 'when logged out' do
        get :new
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'when logged out code 302' do
        get :new
        expect(response).to have_http_status 302
      end
    end

    describe '#create' do
      it 'redirect after create' do
        sign_in user
        random_comm_create
        expect(response).to redirect_to book_path(book)
      end

      it 'when logged out' do
        random_comm_create
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'db records increase after create' do
        sign_in user
        5.times { random_comm_create }
        expect(Book.first.comments.count).to_not eq 0
        expect(Book.first.comments.count).to eq 5
      end

      it 'unsuccessful creation do not get into db' do
        sign_in user
        2.times { random_comm_create }
        count = Book.first.comments.count
        expect(count).to eq 2
        post :create, params: { comment: { text: '', commentator: user.class, commentator_id: user.id },
                                book_id: book.id }
        expect(count == Book.first.comments.count).to be_truthy
      end
    end

    describe '#update' do
      it 'when logged out' do
        patch :update, params: { id: comment.id, book_id: book.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'redirect after update' do
        sign_in user
        random_comm_create
        sign_out user
        comm = Book.first.comments.first
        sign_in admin
        patch :update, params: { comment: { text: 'bug happened' }, id: comm.id, book_id: book.id }
        expect(response).to redirect_to book_path(book)
      end

      it 'db record have changed' do
        sign_in user
        random_comm_create
        comm = Book.first.comments.first
        expect(comm.text).not_to eq 'bug happened'
        patch :update, params: { comment: { text: 'bug happened' }, id: comm.id,
                                       book_id: comm.book.id }
        expect(Book.first.comments.first.text).to eq 'bug happened'
      end
    end

    describe '#destroy' do
      subject do
        sign_in user
        random_comm_create
      end

      it 'when no param :id' do
        expect { delete :destroy, params: {} }.to raise_error
      end

      it 'when logged out' do
        subject
        comm = Book.first.comments.first
        sign_out user
        delete :destroy, params: { id: comm.id, book_id: comm.book.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'redirect after destroy (referer - nil)' do
        subject
        comm = Book.first.comments.first
        delete :destroy, params: { id: comm.id, book_id: comm.book.id }
        expect(response).to redirect_to book_path(comm.book)
      end

      it 'db record successful delete' do
        subject
        comm = Book.first.comments.first
        delete :destroy, params: { id: comm.id, book_id: comm.book.id }
        expect(Book.first.comments.count).to eq 0
      end

      # it 'db record successful delete 2' do
      #   comment
      #   sign_in admin
      #   comm = Book.first.comments.first
      #   delete :destroy, params: { id: comm.id, book_id: comm.book.id }
      #   expect(Book.first.comments.count).to eq 0
      # end
    end
  end
end

# Not working "proper" type...
# it 'db record have changed 2' do
#   sign_in user
#   random_comm_create
#   sign_out user
#   comm = Book.first.comments.first
#   expect(comm.text).not_to eq 'bug happened'
#   puts comm.text
#   sign_in admin
#   patch :update, params: { comment: { text: 'bug happened' }, id: comm.id,
#                                  book_id: comm.book.id }
#   expect(Book.first.comments.first.text).to eq 'bug happened'
#   comm.reload
#   puts comm.text
#   sign_out admin
#   puts '!!!!!'
#   comment
#   comm = Book.last.comments.first
#   puts comm.text
#   puts "#{Book.all.to_a} ,and #{Book.all.pluck(:id)}, and #{Book.all.pluck(:name)}"
#   Book.all.each { |bk| puts "#{bk.comments.to_a} bk - counter #{bk.comments.count}" }
#
#   sign_in admin
#   patch :update, params: { comment: { text: 'bug happened' }, id: comm.id,
#                            book_id: comm.book.id }
#   expect(Book.last.comments.first.text).to eq 'bug happened'
# end
#
# Not working "proper" type single
# it 'db record have changed 3' do
#   comment
#   expect(comment.text).not_to eq 'bug happened'
#   sign_in admin
#   patch :update, params: { comment: { text: 'bug happened' }, id: comment.id,
#                            book_id: comment.book.id }
#   comment.reload
#   expect(Book.first.comments.first.text).to eq 'bug happened'
# end
