class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_comment, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_book, only: [:new, :create, :load_comment]

  def index
    @comments = Comment.all.order('created_at DESC').page(params[:comments_page])
  end

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    user = current_admin_user || current_user
    if user
      comment = @book.comments.new(comment_params.merge(commentable: user))
      comment.valid? ? comment.save : flash[:warning] = 'Something bad happened.'
      redirection
    end
  end

  def update
    if current_admin_user
      if @comment.update_attributes(params.require(:comment).permit(:text, :book_id))
        redirect_to comments_path
      end
    else
      render :show
    end
  end

  def destroy
    @comment.destroy
    redirection
  end

  private

  def load_comment
    @comment = @book.comments.find(params[:id])
  end

  def redirection
    # current_admin_user ? redirect_to(book_path) : redirect_to(book_path(@book))
    redirect_to books_path
  end

  def comment_params
    params.require(:comment).permit(:text, :book_id)
  end

  def load_parent_book
    # @book = Book.friendly.find(params[:book_id])
    @book = Book.find(params[:book_id])
  end
end
