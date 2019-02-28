class RegistersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_register, only: :delete

  def index
    @registers = Register.all
  end

  # def new
  #   @register = Register.new
  # end

  # def create
  #   if current_user
  #     @register = @book.registers.new(user_id: current_user.id)
  #     if @register.save
  #       flash[:success] = 'Register string added'
  #     else
  #       flash[:warning] = 'Something bad happened'
  #     end
  #   end
  #   redirect_back fallback_location: books_url
  # end

  def destroy
    return unless current_admin_user

    if @register.destroy
      flash[:success] = 'Deleting successful'
    else
      flash[:warning] = 'Something bad happened'
    end
  end

  private

  def load_register
    @register = Register.find(params[:id])
  end
end



