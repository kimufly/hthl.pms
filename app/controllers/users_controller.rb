class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    user_email = params[:user_email]
    department_id = params[:department_id]
    @users = User.all
    @users = @users.where('email like ? or name like ? or phone like ?', "%#{user_email}%", "%#{user_email}%") if user_email
    @users = @users.where(department: department_id) if department_id.present?
    @users = @users.page(params[:page] ||= 1)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    case params[:by]
    when 'update_password'
      render :password
    end
  end

  def profile
    @user = current_user
    render 'edit'
  end

  def create
    @user = User.new(user_params)
    if @user.price == nil
      @user.price = 0
    end
    if @user.save
      redirect_to users_path
    else
      render 'new'
    end
  end

  def update
    @user.update(user_params)
  end

  def destroy
    @user = User.find(params[:id])
    #删除软删除
    @user.really_destroy!
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(*User::ACCESSIBLE_ATTRS)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
