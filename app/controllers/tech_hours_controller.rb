class TechHoursController < ApplicationController
  before_action :set_tech_hour, only: [:show, :edit, :update, :destroy]


  # POST /tech_hours
  # POST /tech_hours.json
  def create
    @tech_hour = TechHour.new(tech_hour_params)
    project_id = @tech_hour.project_id
    respond_to do |format|
      if @tech_hour.save
        format.html { redirect_to show_my_project_project_path(project_id)}
        format.json { render :show, status: :created, location: @tech_hour }
      else
        format.html { render :new }
        format.json { render json: @tech_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @tech_hour = TechHour.find(params[:id])
    project_id = @tech_hour.project_id
    respond_to do |format|
      if @tech_hour.update(tech_hour_params)
        format.html { redirect_to show_my_project_project_path(project_id)}
        format.json { render :show, status: :created, location: @tech_hour }
      else
        format.html { redirect_to show_my_project_project_path(project_id)}
        format.json { render json: @tech_hour.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /tech_hours/1
  # DELETE /tech_hours/1.json
  def destroy 
    project_id = @tech_hour.project_id
    @tech_hour.destroy
    respond_to do |format|
      format.html { redirect_to show_my_project_project_path(project_id)}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tech_hour
      @tech_hour = TechHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tech_hour_params
      params.require(:tech_hour).permit(:user_id, :project_id, :time_limit, :describe, :start_at, :document)
    end
end
