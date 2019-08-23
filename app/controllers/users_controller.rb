class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      redirect_to @user
    else
      redirect_to @user
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
 
    redirect_to @user
  end

  def up_personal_password
  end

  def up_personal_data
  end

  def edit_user
  end

  private
  def user_params
      params.require(:user).permit(:name, :email, :role_id, :sex, :phone_number, :locked_at)
  end


end
