class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    respond_to do |format|
      format.json {
        @book = Book.find(params[:book_id])
        @like = @book.likes.create(user_id: current_user.id)
        # flash[:success] = 'Liked'
        redirect_back fallback_location: books_url
      }
    end
  end

  def destroy
    respond_to do |format|
      format.html {
        @book = Book.find(params[:book_id])
        @like = @book&.likes&.find_by user_id: current_user.id
        @like.destroy
        # flash[:warning] = 'Nailed'
        redirect_back fallback_location: books_url
      }
    end
  end
end
