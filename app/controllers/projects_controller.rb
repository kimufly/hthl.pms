class ProjectsController < ApplicationController

  
  def show
    @projects = Project.find(params[:id])
  end


  def new
    @projects = Project.new
  end



  def create
    @customer = Customer.create(customer_params)
    @customer_contact = @customer.customer_contacts.create!(customer_contacts_params)
    @project = Project.new(project_params)
    @project.customer_contacts << @customer_contact
    @project.user = current_user
    @project.customer = @customer
    debugger
    @project.save
    render json: @project
    # print('todo.....:.................\n\n\n\n\n\n\n\n\n\n')
    # print('todo.....:.................\n\n\n\n\n\n\n\n\n\n')
    # id = params[:customer_contact][:id]
    # print('进入方法.unit_name=:'+id+'.................\n\n\n\n\n\n\n\n\n\n')
    #todo.....保存联系人
    # if @projects .save
    #   redirect_to approving_projects_url
    # else
    #   render "approving_flow_apply"
    # end
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
    @projects = Project.all
    render 'projects/todo'
  end

  def show_approving
  end

  def approving_flow_apply
    @project = Project.new
    @customer_contact = CustomerContact.where(unit_name: '新华集团').first
    @users = User.all
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

  
  private
  def project_params
      params.require(:project).permit(:name, :expected_at, :support_details, :support_details, :tech_auditor, :auditor)
  end

  def customer_params
    params.require(:project).require(:customer).permit(:name)
  end

  def customer_contacts_params
    params.require(:project).require(:customer).require(:customer_contacts).permit(:name, :telephone, :phone_number, :other_phone)
  end
end
