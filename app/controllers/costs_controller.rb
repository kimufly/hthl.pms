class CostsController < ApplicationController
  def index
    name = params[:name]
    @project_users = ProjectUser.all
    @project_users = ProjectUser.joins(:user).where('name like ? ', "%#{name}%") if name.present?
    @project_users = @project_users.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end
  end
end