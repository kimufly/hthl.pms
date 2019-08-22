class ProjectsController < ApplicationController
  def index

    @projects = current_user.projects
  end

  def approving
    @projects = current_user.projects.approving
  end

  def todo
    @projects = current_user.projects.approving
  end
  
end
