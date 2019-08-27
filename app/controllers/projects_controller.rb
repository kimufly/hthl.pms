class ProjectsController < ApplicationController
  def index
    @page_title = "我的项目"
    @projects = current_user.projects
  end

  def approving
    @page_title = "我的申请"
    @projects = current_user.projects.approving
    render 'projects/approving'
  end

  def todo
    @page_title = "我的待办"
    @projects = Project.all
    render 'projects/todo'
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
