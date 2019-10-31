class SatisfactionsController < ApplicationController
    layout "satisfaction"
  
    def show
      @satisfaction = Satisfaction.find(params[:id])
      if @satisfaction
        @flag = 1
      end
    end
  
    def new
      @satisfaction = Satisfaction.new
    end
  
    def create
      @satisfaction = Satisfaction.new(satisfaction_params)
      if @satisfaction.save
        @flag = 1
        redirect_to satisfactions_path(article)  
      end
    end
  
    private
    def satisfaction_params
      params.require(:satisfaction).permit(:project_id, :case_num, :service_type, :start_at, :use_at, :true_at, :service_quality, :complaints_hotline, :service_engineer, :engineer, :engineer_satisfaction, :technical_support, :sales_service, :customer_eturn_visit, :other_opinions, :created_at, :updated_at)
    end
  end
  