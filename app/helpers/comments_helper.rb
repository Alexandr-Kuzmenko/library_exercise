module CommentsHelper
  def author_user?(comm)
    unless comm.try(:commentator)
      return false
    else
      if comm.commentator.eql?('User')
        @usr = User.find(id: comm.commentator_id)
      elsif comm.commentator.eql?('AdminUser')
        @usr = AdminUser.find(id: comm.commentator_id)
      end
    end
  end
end
