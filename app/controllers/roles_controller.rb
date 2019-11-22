class RolesController < ApplicationController
  before_action :set_role, only: [:edit, :update, :show]

  def index
    name = params[:name]
    @roles = Role.all
    @roles = @roles.where('name like ? ', "%#{name}%") if name.present?
    @roles = @roles.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
  end

  def new
    @role = Role.new
  end

  def edit
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      redirect_to roles_path
    else
      render 'new'
    end
  end

  def update
    @role = Role.find(params[:id])
    if @role.update(role_params)
      redirect_to roles_path
    else
      render 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    exist_role = Role.where('name = ?', '普通角色').taken
    if exist_role
      User.where('role_id = ?', @role.id).update_all(role_id: exist_role.id)
    else
      r = Role.new(:name => "普通角色")
      r.save
      User.where('role_id = ?', @role.id).update(role_id: r.id)
    end
    @role.destroy
    redirect_to roles_path
  end

  private
  def set_role
    @role = Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:type, :name, :explain, :status)
  end
end
