class CommentsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :load_comment, only: %i[show edit update destroy author_matched]
  before_action :load_parent_book, only: %i[index new create load_comment]

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
    if author_matched
      if @comment.update_attributes(comment_params)
        flash[:success] = 'Comment text changed'
      else
        flash[:warning] = 'Unpermitted operation'
      end
    end
    redirection
  end

  def destroy
    if author_matched
      if @comment.destroy
        flash[:success] = 'Comment deleted'
      else
        flash[:warning] = 'Unpermitted operation'
      end
    end
    redirection
  end

  private

  def author_matched
    return false unless user = current_admin_user || current_user
    return true if user.class.eql?(AdminUser)
    return true if @comment.commentator == user.class.to_s && @comment.commentator_id == user.id.to_s

    false
  end

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
