class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    user_email = params[:user_email]
    department_id = params[:department_id]
    @users = User.all
    @users = @users.where('email like ?', "%#{user_email}%") if user_email
    @users = @users.where(department: department_id) if department_id.present?
    @users = @users.page(params[:page] ||= 1)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @user = User.find(params[:id])
    redirect_to edit_user_path
  end

  def new
    @roles = Role.all
    @user = User.new
  end

  def edit
    @roles = Role.all
    case params[:by]
    when 'update_password'
      render :password
    else
      render :form
    end
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
    case params[:by]
    when 'update_password'
      update_password
    else
      if @user.update(user_params)
        redirect_to users_path
      else
        render 'edit'
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    #删除软删除
    @user.really_destroy!
    redirect_to users_path
  end

  def find_by_role_id
    @role = Role.find(current_user.role_id)
    @users = @role.users
  end 

  private

  def update_password
    @page_title = '修改个人密码'
    if current_user.update_with_password(user_params)
      redirect_to root_path, notice: '密码更新成功，现在你需要重新登陆。'
    else
      render 'password'
    end
  end

  def user_params
    params.require(:user).permit(*User::ACCESSIBLE_ATTRS)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
