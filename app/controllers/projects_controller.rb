class ProjectsController < ApplicationController
  before_action :get_project, only: [:edit, :show]
  
  def show
  end

  def edit
  end

  def new
    @users = User.all
    @project = Project.new
  end

  def create
    @customer = Customer.create(customer_params)
    @customer_contact = @customer.customer_contacts.create!(customer_contacts_params)
    @project = Project.new(project_params)
    @project.customer_contacts << @customer_contact
    @project.user = current_user
    @project.customer = @customer
    @project.save
    redirect_to approving_projects_url
  end

  def update
    @project = Project.find(params[:id])
    
    @project.update(project_params)
    @customer = Customer.find(@project.customer_id)
    @customer.update(customer_params)

    redirect_to approving_projects_url
  end

  def destroy
    @project = Project.find.find(params[:id])
    @project.destroy
    redirect_to approving_projects_url
  end

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
    @projects = Project.todo(current_user.id)
    render 'projects/todo'
  end



  def project_flow_apply
  end

  def project_change_flow_apply
  end

  def project_finish_file_upload
  end

  
  private
  def get_project
    @project = Project.find(params[:id])
  end

  def project_params
      params.require(:project).permit(:name, :expected_at, :support_details, :tech_auditor, :auditor)
  end

  def customer_params
    params.require(:project).require(:customer).permit(:name)
  end

  def customer_contacts_params
    params.require(:project).require(:customer).require(:customer_contacts).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position)
  end
end
