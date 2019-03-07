require 'rails_helper'

class BooksControllerTest < ActionController::TestCase
  RSpec.describe BooksController, type: :controller do
    include Devise::Test::ControllerHelpers

    let(:book) { FactoryBot.create(:book) }
    let(:taken_book) { FactoryBot.create(:book, status: false) }
    let(:user) { FactoryBot.create(:user) }

    def random_bk_create
      img_link = Faker::Internet.url('abali.ru', '/wp-content/uploads/2012/01/staraya_oblozhka_knigi.jpg')
      post :create, params: { book: { name: Faker::Book.unique.title, author: Faker::Book.author,
                                      description: Faker::Lorem.paragraph, remote_envelope_url: img_link } }
    end

    describe '#index' do
      subject { get :index }
      include_examples 'index examples'
      # include_examples 'index examples', :books, Book.all

      it 'equal to object when objects count: 1' do
        subject
        book
        expect(assigns(:books)).to eq([book])
      end
    end

    describe '#show' do
      subject { get :show, params: { id: book.id } }
      include_examples 'show examples'

      it 'when no param :id' do
        expect { get :show, params: {} }.to raise_error
      end
    end

    describe '#new' do
      subject do
        sign_in user
        get :new
      end
      include_examples 'new examples'

      it 'when logged out' do
        get :new, params: {}
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#edit' do
      subject do
        sign_in user
        get :edit, params: { id: book.id }
      end
      include_examples 'edit examples'

      it 'when logged out' do
        get :edit, params: { id: book.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe '#create' do
      it 'when logged out' do
        random_bk_create
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'redirect_back' do
        sign_in user
        book
        from book_path(book)
        random_bk_create
        expect(response).to redirect_to book_path(book)
        from root_path
        random_bk_create
        expect(response).to redirect_to root_path
        from users_path
        random_bk_create
        expect(response).to redirect_to users_path
      end

      it 'db records increase after create' do
        sign_in user
        count = Book.count
        random_bk_create
        expect(count + 1 == Book.count).to be_truthy
      end

      it 'unsuccessful creation do not get into db' do
        sign_in user
        count = Book.count
        img_link = Faker::Internet.url('abali.ru', '/wp-content/uploads/2012/01/staraya_oblozhka_knigi.jpg')
        post :create, params: { book: { name: nil, author: Faker::Book.author,
                                        description: Faker::Lorem.paragraph, remote_envelope_url: img_link } }
        expect(count == Book.count).to be_truthy
      end
    end

    describe '#update' do
      it 'when logged out' do
        patch :update, params: { id: book.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'redirect after update' do
        sign_in user
        from users_path
        patch :update, params: { book: { name: Faker::Book.unique.title }, id: book.id }
        expect(response).to redirect_to users_path
      end

      it 'db record have changed' do
        sign_in user
        record = book.author
        patch :update, params: { book: { author: 'Vasiliy Pupkin' }, id: book.id }
        expect(Book.find_by(author: record)).to be_nil
      end
    end

    describe '#destroy' do
      it 'when no param :id' do
        expect { delete :destroy, params: {} }.to raise_error
      end

      it 'when logged out' do
        delete :destroy, params: { id: book.id }
        expect(response).to redirect_to '/users/sign_in'
      end

      it 'redirect after destroy (referer - nil)' do
        sign_in user
        delete :destroy, params: { id: book.id }
        expect(response).to redirect_to books_path
      end
    end

    describe 'take method' do
      before(:each) do
        sign_in user
      end

      it 'taken book status changed' do
        patch :take, params: { id: book.id }
        book.reload
        expect(book.status).to be_falsey
      end

      it 'registers count increases' do
        cnt = Register.count
        patch :take, params: { id: book.id }
        expect(cnt < Register.count).to be_truthy
      end

      it 'redirect after take' do
        from books_path
        patch :take, params: { id: book.id }
        expect(response).to redirect_to books_path
      end

      it 'redirect after take (referer - nil)' do
        patch :take, params: { id: book.id }
        expect(response).to redirect_to book_path(book)
      end

      it 'logged out try' do
        sign_out user
        patch :take, params: { id: book.id }
        expect(response).to redirect_to '/users/sign_in'
      end
    end

    describe 'return method' do
      before(:each) do
        sign_in user
      end

      it 'returned book status changed' do
        patch :return, params: { id: taken_book.id }
        taken_book.reload
        expect(taken_book.status).to be_truthy
      end

      it "register's 'expired' status - true" do
        patch :take, params: { id: book.id }
        expect(Register.count).to eq 1
        expect(Register.last.expired).to be_falsey
        patch :return, params: { id: book.id }
        expect(Register.last.expired).to be_truthy
      end
    end
  end
end
