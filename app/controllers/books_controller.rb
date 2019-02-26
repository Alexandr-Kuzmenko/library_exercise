class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_book, only: [:show, :edit, :update, :destroy, :take, :return]

  def index
    @top_books = Book.limit(5).order('likes_count desc')
    @books = Book.all.where(status: true)
    @books_taken = Book.all.where(status: false)
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Creation successful'
    else
      flash[:warning] = 'Book has not been saved'
    end
    redirection
  end

  def update
    if @book.update(book_params)
      flash[:success] = 'Book parameters have been changed'
      redirection
    else
      flash[:warning] = 'Book parameters update have been failed'
      render :edit
    end
  end

  def destroy
    flash[:warning] = 'Some reason prevents deleting' unless @book.destroy
    redirection
  end

  def take
    @book.update_attributes(status: false)
    @book.registers.create(user_id: current_user.id)
    flash[:success] = 'Book taken'
    redirect_to book_path(@book)
  end

  def return
    @book.update_attributes(status: true)
    @register = @book.registers.where(user_id: current_user.id).sort( { 'created_at': -1 } ).first
    @register.update_attributes(expired: true)
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :envelope, :description, :status)
  end

  def redirection
    # current_admin_user ? redirect_to(books_path) : redirect_to(books_path)
    redirect_back fallback_location: books_url
  end

  def load_book
    # @book = Book.friendly.find(params[:id])
    @book = Book.find(params[:id])
  end
end
