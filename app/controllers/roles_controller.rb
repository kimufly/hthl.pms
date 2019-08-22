class RolesController < ApplicationController
  def index
    @roles = Role.all
  end

  def edit_role
  end

  def role_permission
  end
  
end
