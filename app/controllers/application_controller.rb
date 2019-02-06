class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # protect_from_forgery with: :null_session
  #before_action :authenticate_user!, except: [:index], unless: :admin_user_signed_in?

  def top_books
    @top_books = Book.limit(5).order('likes_count desc').to_a
  end
end
