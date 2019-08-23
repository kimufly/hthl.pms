class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects
  end

  def approving
    @projects = current_user.projects.approving
  end

  def todo
  end

  def show_approving
  end

  def approving_flow_apply
  end

  def approving_change_flow_apply
  end

  def show_project
  end

  def project_flow_apply
  end

  def project_change_flow_apply
  end

  def project_finish_file_upload
  end


  
end
