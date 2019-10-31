require 'csv'
class ProjectsController < ApplicationController
  before_action :get_project, only: [:edit, :show]
  
  def index 
    @page_title = "查看所有项目列表"
    name = params[:name]
    status = params[:status]
    @projects = Project.all
    @projects = @projects.where('name like ? ', "%#{name}%") if name.present?
    @projects = @projects.where(status: status) if status.present?
    @projects = @projects.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end 
  end
  
  def show
  end

  def edit
    @users = User.all
    @customers = Customer.all
  end

  def new
    @users = User.all
    @customers = Customer.all
    @project = Project.new
   
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    @project.approved_at = Time.new
    if @project.save
      redirect_to approving_projects_url
    end  
  end

  def update
    Project.transaction do  
      @project = Project.find(params[:id]) # nil
      @project.update(project_params)
      if @project
        redirect_to approving_projects_url
      end
    end
  end  


  def project
    @page_title = "我的项目"
    name = params[:name]
    status = params[:status]
    @projects = current_user.projects
    @projects = @projects.where('name like ? ', "%#{name}%") if name.present?
    @projects = @projects.where(status: status) if status.present?
    @projects = @projects.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end    
  end

  def approving
    @page_title = "我的申请"
    name = params[:name]
    status = params[:status]
    @projects = current_user.projects.approving
    @projects = @projects.where('name like ? ', "%#{name}%") if name.present?
    @projects = @projects.where(status: status) if status.present?
    @projects = @projects.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end    
  end

  def todo
    @page_title = "我的待办"
    name = params[:name]
    status = params[:status]
    @projects = Project.todo(current_user.id)
    @projects = @projects.where('name like ? ', "%#{name}%") if name.present?
    @projects = @projects.where(status: status) if status.present?
    @projects = @projects.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end    
  end

  def show_my_project
    name = params[:name]
    @users = User.all
    @project = Project.find(params[:id])
    @tech_hours = TechHour.where(project_id: params[:id])
    @user = User.where('name like ? ', "%#{name}%").first if name.present?
    if @user
      @tech_hours = TechHour.where(user_id: @user.id)
    end
    #获取项目完结申请文档
    @project_passs = ProjectPass.where(project_id: params[:id])
    @tech_hours = @tech_hours.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def audit
    @users = User.all
    @project = Project.find(params[:id])
    @customers = Customer.all
  end

  def submit_audit
    Project.transaction do  
      @project = Project.find(params[:id])
      @project.update(time_limit: params[:time_limit])
      @project.update(remake: params[:remake])
      if params[:status].eql? "doing"
        @project.update(doing_at: Time.new)
      end
      @project.update(status: params[:status])
      if params[:tech_user]
        for i in params[:tech_user] do  
          @project_user = ProjectUser.new
          @project_user.user_id = i
          @project_user.project_id = params[:id]          
          @project_user.user_type = "tech_user"
          @project_user.save
        end 
      end
      @users = User.all
    end
    redirect_to todo_projects_url
  end

  def project_details
    @project_users = ProjectUser.where(project_id: params[:id])
    @documents = Document.order(created_at: :desc).first(5)
    @project_passs = ProjectPass.order(created_at: :desc).first(5)
    @project = Project.find(params[:id])
    @project_users = ProjectUser.where(project_id: params[:id])
  end

  def create_customer
    @customer = Customer.new(customer_params)
      if @customer.save
        redirect_to new_project_path
      end 
  end

  def update_customer_contact
    @customer_contact = CustomerContact.find(params[:customer_contact_id])
    @customer_contact.update(name: params[:name])
    @customer_contact.update(telephone: params[:telephone])
    @customer_contact.update(phone_number: params[:phone_number])
    @customer_contact.update(other_phone: params[:other_phone])
    @customer_contact.update(position: params[:position])
    @customer_contact.update(email: params[:email])
    @customer_contact.update(address: params[:address])
    @customer_contact.update(customer_id: params[:customer_id])
    redirect_to new_project_path
  end

  def delete_customer_contact

  end

  def create_customer_contact
    @customer_contact = CustomerContact.new(customer_contact_params)
    if @customer_contact.save
      redirect_to new_project_path
    end 
  end

  def project_over_auditor
    @project_pass = ProjectPass.find(params[:id])
    @project_pass.update(pass: params[:pass])
    @project_pass.update(remark: params[:remark])
    redirect_to show_my_project_project_path(@project_pass.project_id)
  end

  def import
    project_id = params[:id]
    ProjectPass.transaction do
      success = 0
      failed_records = []
      CSV.parse( params[:csv_file].read, headers: true) do |row|
        projectPass = ProjectPass.new( 
            :project_id => project_id,
            :name => str_formt(row[2]),
            :user_id => current_user.id,
            :created_at => Time.new,
            :remark => str_formt(row[6]))
        if projectPass.save
          success += 1
        else
          failed_records << [row, registration]
          Rails.logger.info("#{row} ----> #{projectPass.errors.full_messages}")
        end
      end
        flash[:notice] = "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"
    end
    redirect_to show_my_project_project_path(project_id)
  end
  

  def str_formt(str)
    if str
      return str.force_encoding("gb2312").encode(Encoding.find("UTF-8"))
    else
      return ''
    end
  end

  def download_project_pass  
    p = ProjectPass.find(params[:id]) 
    pass = p.pass
    if pass.eql? "done"
      pass = "通过"
    elsif pass.eql? "refuse"
      pass = "拒绝"
    elsif pass.eql? "correction"
      pass = "驳回"
    end
    respond_to do |format|
      format.html
      format.js
      format.csv {
        csv_string = CSV.generate do |csv|
          csv << ["编号", "项目名称", "文档名称", "上传人", "上传时间", "文档评审结果", "备注"]   
            csv << [p.id, p.project.name, p.name, p.user.name, p.created_at, pass, p.remark]
        end
        send_data csv_string, :filename => "下载-项目完成文档-#{Time.now.to_s(:number)}.csv"
      }
    end
  end
  
      
  def delete_project_pass
    @project_pass = ProjectPass.find(params[:id])
    if @project_pass.destroy
      redirect_to show_my_project_project_path(@project_pass.project_id)
    end
  end

  def download_tech_hour
    th = TechHour.find(params[:id])
    url = url_for(th.document)
    url2 = rails_blob_path(th.document, disposition: "attachment")
    
    send_file "rails/active_storage/blobs/"+params[:filename] unless params[:filename].blank?
    redirect_to show_my_project_project_path(th.project_id)
    #send_file "public/uploads/"+params[:filename] unless params[:filename].blank?
  end

  def find_by_status
    @projects = Project.where(status: params[:status])
  end

  def project_flow_apply
    #TODO
  end

  def project_change_flow_apply
    #TODO
  end

  def project_finish_file_upload
    #TODO
  end

  
  private
  def get_project
    @project = Project.find(params[:id])
  end


  def project_params
    params.require(:project).permit(:name, :expected_at, :support_details, :tech_auditor, :auditor, :status, :customer_id)
  end

  def customer_params
    params.require(:project).require(:customer).permit(:name)
  end

  def customer_contacts_params
    params.require(:project).require(:customer).require(:customer_contacts).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position)
  end

  def customer_attributes
    params.require(:project).require(:customer_attributes).permit(:name)
  end

  def customer_contacts_attributes
    params.require(:project).require(:customer_attributes).require(:customer_contacts_attributes).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position)
  end

  private
  def customer_params
    params.require(:customer).permit(:name)
  end


  def customer_contact_params
    params.require(:customer_contact).permit(:name, :telephone, :phone_number, :other_phone, :email, :address, :position, :customer_id)
  end

end
