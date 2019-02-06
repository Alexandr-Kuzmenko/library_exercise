class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = Book.friendly.find(params[:book_id])
    @book = Book.find(params[:book_id])
    check_like ? nail_like : put_like
    redirect_back fallback_location: books_url
  end

  private

  def put_like
    @like = current_user.likes.create(book: @book)
  end

  def nail_like
    @like.destroy
  end

  def check_like
    @like = current_user.likes.find_by book: @book
  end
end
