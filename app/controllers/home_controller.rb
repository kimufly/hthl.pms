class HomeController < ApplicationController

  def index
    @month_tech_hours = TechHour.where("start_at >= ? AND start_at <= ?", Time.now.beginning_of_month, Time.now.end_of_month)
    @weeks_tech_hours = TechHour.where("start_at >= ? AND start_at <= ?", Time.now.at_beginning_of_week, Time.now.at_end_of_week).order('start_at ASC')
    #@weeks_tech_hours = @weeks_tech_hours.pluck(:time_limit)
    
    #@weeks_tech_hours = @weeks_tech_hours.where('time_limit')
    #group_by { |t| t.start_at.beginning_of_day }

    
    byebug
    @result_arr = Array.new
    for @weeks_tech_hours in @weeks_tech_hours
      puts @weeks_tech_hours.time_limit
      @result_arr << @weeks_tech_hours.time_limit * @weeks_tech_hours.user.price
    end
    
    

    @projects = Project.all
    @project_top_5 = ProjectUser.left_outer_joins(:project, :user).distinct.select('COUNT(project_users.id), project_users.project_id, COUNT(projects.time_limit * users.price) AS project_count').group('project_users.id, project_users.project_id').order('project_count DESC').first(5)
  end
end
