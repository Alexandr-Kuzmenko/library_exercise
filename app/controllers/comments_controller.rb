class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :load_comment, only: [:show, :edit, :update, :destroy]
  before_action :load_parent_book, only: [:index, :new, :create, :load_comment]

  def index
    @comments = @book.comments.all.order('created_at DESC')#.page(params[:comments_page])
  end

  def show; end

  def new
    # @comment = @book.comments.new
    @comment = Comment.new
  end

  def edit; end

  def create
    user = current_admin_user || current_user
    if user
      comment = @book.comments.new(comment_params.merge(commentator: user.class, commentator_id: user.id ))
      comment.valid? ? comment.save : flash[:warning] = 'Invalid comment'
      redirection
    end
  end

  def update
    if current_admin_user
      @comment.update_attributes(comment_params)
    else
      flash[:warning] = 'Unpermitted operation'
    end
    redirection
  end

  def destroy
    @comment.destroy
    redirection
  end

  private

  def load_parent_book
    @book = Book.find(params[:book_id])
  end

  def load_comment
    @comment = @book.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end

  def redirection
    redirect_back fallback_location: book_url(@book)
  end
end
