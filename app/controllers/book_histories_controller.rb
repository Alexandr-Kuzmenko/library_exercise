class BookHistoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book_history, only: [:destroy]
  before_action :load_parent_book, only: [:new, :load_book_history, :return_book]

  def new
    @book.status ? take_book : flash[:warning] = 'Already taken'
  end

  def destroy
    @book_history.destroy
  end

  private

  def take_book
    @book.status = false
    @book.book_histories.create(user: current_user, action: 'taken')
    flash[:success] = 'Book taken'
  end

  def return_book
    @book.status = true
    @book.book_histories.create(user: current_user, action: 'returned')
    flash[:success] = 'Book returned'
  end

  def load_book_history
    @book_history = @book.book_histories.find(params[:id])
  end

  def load_parent_book
    # @book = Book.friendly.find(params[:book_id])
    @book = Book.find(params[:book_id])
  end
end
