require 'csv'
class DocumentsController < ApplicationController
  


  def index
    @documents = Document.all
    @documents = @documents.page(params[:page] ||= 1)
    respond_to do |format|
      format.html
      format.js
      format.csv {
        @documents = @documents.reorder("id ASC")
        csv_string = CSV.generate do |csv|
          csv << ["编号", "项目名称", "文档标题", "文档类型", "创建人", "上传时间"]
          @documents.each do |d|
            csv << [d.id, d.project.name, d.name, d.document_type, d.user.name, d.created_at]
          end
        end
        send_data csv_string, :filename => "导出-文档管理模块-#{Time.now.to_s(:number)}.csv"
      }
    end
  end

  def new
    @document = Document.new
  end

  def destroy
    @Document = Document.find(params[:id])
    @Document.destroy
    redirect_to documents_path
  end

  def upload_files

  end

  def share_files
    my_token = Token.new
    my_token.token = SecureRandom.base64(64).sub(/\+/,"")
    my_token.user_id = current_user.id
    my_token.created_at = Time.new
    my_token.valid_at = Time.now+5.minutes
    if my_token.save  
    else
      redirect_to documents_url
    end
    ip= my_first_private_ipv4.ip_address unless my_first_private_ipv4.nil?   
    @url = 'http://192.168.13.156:3000/documents/init_share?token=' + my_token.token
  end

  def my_first_private_ipv4
    Socket.ip_address_list.detect{|intf| intf.ipv4_private?}
  end


  def init_share
    my_token = Token.where(token: params[:token]).take
    if my_token
      if my_token.valid_at > Time.new
        redirect_to documents_url
      else
        redirect_to msg_index_path
      end
    else 
      redirect_to msg_index_path
    end
  end

  def import
    Document.transaction do
      success = 0
      failed_records = []
      CSV.parse( params[:csv_file].read, headers: true) do |row|
        project = Project.where(name: row[1]).first
          registration = Document.new( 
            :project_id =>  project.id,
            :name => row[2],
            :document_type => row[3],
            :user_id => current_user.id,
            :created_at => Time.new)
        if registration.save
          success += 1
        else
          failed_records << [row, registration]
          Rails.logger.info("#{row} ----> #{registration.errors.full_messages}")
        end
      end
        flash[:notice] = "总共汇入 #{success} 笔，失败 #{failed_records.size} 笔"
    end
    redirect_to documents_url()
  end
  protected

  def str_formt(str)
    if str
      return str.force_encoding("gb2312").encode(Encoding.find("UTF-8"))
    else
      return ''
    end
  end



end
