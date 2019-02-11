class BooksController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all.to_a
  end

  def show; end

  def new
    @book = Book.new
  end

  def edit; end

  def create
    user = current_admin_user || current_user
    render :new unless user
    @book = Book.new(book_params)
    if @book.save
      flash[:success] = 'Creation successful.'
    else
      flash[:warning] = 'Book has not been saved.'
    end
    redirection
  end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = 'Book parameters have been changed.'
      redirection
    else
      flash[:warning] = 'Book parameters update cancelled.'
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private

  def redirection
    # current_admin_user ? redirect_to(books_path) : redirect_to(books_path)
    redirect_to books_path
  end

  def load_book
    # @book = Book.friendly.find(params[:id])
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:name, :author, :envelope, :description)
  end
end
