class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    # @book = Book.friendly.find(params[:book_id])
    @book = Book.find(params[:book_id])
    check_like ? nail_like : put_like
    redirect_back fallback_location: books_url
  end

  private

  def put_like
    @like = @book.likes.create(user: current_user)
    flash[:success] = 'Liked!'
  end

  def nail_like
    @like.destroy
    flash[:warning] = 'Like nailed'
  end

  def check_like
    @like = @book.likes.find_by user: current_user
  end
end
