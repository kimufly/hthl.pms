class ProjectUsersController < ApplicationController
  def index
    @page_title = "人员管理"
    name = params[:name]
    status = params[:status]
    @project_users = ProjectUser.all
    @project_users = @project_users.user.where('name like ? ', "%#{name}%") if name.present?
    @project_users = @project_users.project.where(status: status) if status.present?
    @project_users = @project_users.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end 
    
  end

  def show
    @project_user = ProjectUser.find(params[:id])
  end


  def new
    @users = User.all
    @projects = Project.all
    @project_users = ProjectUser.new
  end

  def edit
    @users = User.all
    @projects = Project.all
    @project_user = ProjectUser.find(params[:id])
  end

  def create
    @project_user = ProjectUser.new(project_user_params)
    if @project_user.save
      redirect_to project_users_path
    else
      @users = User.all
      @projects = Project.all
      render 'new'
    end
  end

  def update
    @project_user = ProjectUser.find(params[:id])
    if @project_user.update(project_user_params)
      redirect_to project_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @project_user = ProjectUser.find(params[:id])
    @project_user.destroy
    redirect_to project_users_path
  end


  private
  def project_user_params
    params.require(:project_user).permit(:type, :project_id, :user_id)
  end



end
