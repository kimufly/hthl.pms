class HomeController < ApplicationController

  def index
    #yebug
    @month_tech_hours = TechHour.where("start_at >= ? AND start_at <= ?", Time.now.beginning_of_month, Time.now.end_of_month)
    @weeks_tech_hours = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * SUM(users.price)) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.at_beginning_of_week, Time.now.at_end_of_week).group('date(tech_hours.start_at)').order('start_at ASC')
    @result_weeks_cb = Array[11.0, 2.2, 70.4]
    @result_weeks_time = Array['2016-02-06', '2019-05-03', '2016-04-06']
    
    for tech_hours in @weeks_tech_hours
      #@result_weeks_cb << tech_hours.time_limit
    end
    
    # @result_weeks = Array[0,0,0,0,0,0,0]
    # tech_hours = TechHour.new
    # for tech_hours in @weeks_tech_hours
    #   if tech_hours.start_at.wday == 0
    #     @result_weeks[6] = tech_hours.time_limit
    #   elsif tech_hours.start_at.wday == 1
    #     @result_weeks[0] = tech_hours.time_limit
    #   elsif tech_hours.start_at.wday == 2
    #     @result_weeks[1] = tech_hours.time_limit
    #   elsif tech_hours.start_at.wday == 3
    #     @result_weeks[2] = tech_hours.time_limit
    #   elsif tech_hours.start_at.wday == 4
    #     @result_weeks[3] = tech_hours.time_limit
    #   elsif tech_hours.start_at.wday == 5
    #     @result_weeks[4] = tech_hours.time_limit
    #   elsif tech_hours.start_at.wday == 6
    #     @result_weeks[5] = tech_hours.time_limit
    #   end
    # end
    
    @projects = Project.all
    @project_top_5 = ProjectUser.left_outer_joins(:project, :user).distinct.select('COUNT(project_users.id), project_users.project_id, COUNT(projects.time_limit * users.price) AS project_count').group('project_users.id, project_users.project_id').order('project_count DESC').first(5)
  end
end
