class RegistersController < ApplicationController
  before_action :load_parent_book, only: [:new, :create]

  def index
    @registers = Register.all
  end

  def new
    @register = Register.new
  end

  def create
    if current_user
      @register = @book.registers.new(user_id: current_user.id)
      if @register.save
        flash[:success] = 'Register string added'
      else
        flash[:warning] = 'Something bad happened'
      end
    end
    redirect_back fallback_location: books_url
  end

  def destroy
    if current_admin_user
      # @register = @book.registers.find(params[:id])
      @register = Register.find(params[:id])
      @register.destroy ? flash[:success] = 'Deleting successful' : flash[:warning] = 'Something bad happened'
    end
  end
end



