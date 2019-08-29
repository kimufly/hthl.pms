class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def up_password
    @page_title = "修改个人密码"
    @user = User.find(params[:email, password])
    if @user.nil?
      errors.add(:old_password, "旧密码错误")
      #todo...用户名密码错误
    else
      @user.update_attributes(password: new_password)  
      redirect_to root_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
   
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end


  def up_password
    @page_title = "修改个人密码"
    user = User.first
    old_password = params[:user][:old_password]
    password = params[:user][:password]
    password_confirmation = params[:user][:password_confirmation]
    if user.valid_password?(old_password)
      if user.valid_password? old_password
         user.password = password
         user.password_confirmation = password_confirmation
         user.save
         redirect_to destroy_user_session_url
      else
        #旧密码错误.....
        redirect_to up_personal_password_users_url
      end
    else
      #旧密码错误.....
      redirect_to up_personal_password_users_url
    end
  end



  def up_personal_password
  end

  def up_personal_data
  end


  private
  def user_params
      params.require(:user).permit(:name, :email, :role_id, :sex, :phone_number, :status, :password, :locked_at, :explain)
  end


end
