module BooksHelper
  def exist_like?(obj)
    #@like = current_user&.likes&.find_by book: obj
    @like = obj&.likes&.find_by user_id: current_user.id
  end
end
