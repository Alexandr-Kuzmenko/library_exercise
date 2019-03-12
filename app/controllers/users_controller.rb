class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_user, only: %i[index edit update destroy]

  def edit; end

  def update
    if @user.update_attributes(params.require(:user).permit(:nickname, :avatar))
      # , :encrypted_password, :password_confirmation))
      flash[:success] = 'Changes successful'
    else
      flash[:warning] = 'Information updating went wrong'
    end
    redirect_to users_path
  end

  def destroy
    if @user.destroy
      flash[:success] = 'Deleting successful'
    else
      flash[:warning] = 'Deleting went wrong'
    end
    redirect_to root_path
  end

  private

  def load_user
    # @user = User.includes(:/*taken books*/).find(current_user.id)
    @user = User.includes(:registers).find(id: current_user.id)
  end

  def user_params
    params.require(:user).permit(:nickname, :avatar)
  end
end
