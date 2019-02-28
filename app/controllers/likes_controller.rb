class LikesController < ApplicationController
  before_action :authenticate_user!

  def new
    check_like ? nail_like : put_like
    redirect_back fallback_location: books_url
  end

  private

  def put_like
    @like = @book.likes.create(user_id: current_user.id)
    flash[:success] = 'Liked'
  end

  def nail_like
    @like.destroy
    flash[:warning] = 'Nailed'
  end

  def check_like
    @book = Book.find(params[:book_id])
    @like = @book&.likes&.find_by user_id: current_user.id
  end
end
