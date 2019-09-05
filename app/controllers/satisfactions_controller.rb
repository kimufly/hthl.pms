class SatisfactionsController < ApplicationController
    layout "satisfaction"
  
    def show
      @satisfaction = Satisfaction.find(params[:id])
    end
  
    def new
      @satisfaction = Satisfaction.new
    end
  
    def create
      @satisfaction = Satisfaction.new(satisfaction_params)
      if @satisfaction.save  
        redirect_to root_path
        # 客户提交满意度成功的感谢页面
      else
        redirect_to satisfactions_path
      end
    end
  
    private
    def satisfaction_params
      params.require(:satisfaction).permit(:project_id, :case_num, :service_type, :start_at, :use_at, :true_at, :service_quality, :complaints_hotline, :service_engineer, :engineer, :engineer_satisfaction, :technical_support, :sales_service, :customer_eturn_visit, :other_opinions, :created_at, :updated_at)
    end
  end
  