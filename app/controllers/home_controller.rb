class HomeController < ApplicationController

  def index 
    @tech_hours = nil
    if params[:graduation_day]
      among_time = params[:graduation_day].gsub(' ','').split("-")
      start_time = among_time[0].to_time.beginning_of_day
      end_time = among_time[1].to_time.at_end_of_day
      @tech_hours = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * SUM(users.price)) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', start_time, end_time).group('date(tech_hours.start_at)').order('start_at ASC')    

    else
      if params[:type].eql? "week"
        #本周
        @tech_hours = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * SUM(users.price)) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.at_beginning_of_week, Time.now.at_end_of_week).group('date(tech_hours.start_at)').order('start_at ASC')
      elsif params[:type].eql? "month"
        #本月
        @tech_hours =TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * SUM(users.price)) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.beginning_of_month, Time.now.end_of_month).group('date(tech_hours.start_at)').order('start_at ASC')
      elsif params[:type].eql? "quarter"
        #本季度
        @tech_hours =TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * SUM(users.price)) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.beginning_of_quarter, Time.now.end_of_quarter).group('date(tech_hours.start_at)').order('start_at ASC')
      else
        #默认本周
        @tech_hours = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * SUM(users.price)) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.at_beginning_of_week, Time.now.at_end_of_week).group('date(tech_hours.start_at)').order('start_at ASC')
      end
    end
    
    @result_date = Array.new
    @result_time = Array.new
    for tech_hours in @tech_hours
      @result_date.push(tech_hours.time_limit)
      @result_time.push(tech_hours.start_at.strftime('%Y-%m-%d'))
    end
    
    @projects = Project.all
    @project_top_5 = ProjectUser.left_outer_joins(:project, :user).distinct.select('COUNT(project_users.id), project_users.project_id, COUNT(projects.time_limit * users.price) AS project_count').group('project_users.id, project_users.project_id').order('project_count DESC').first(5)
  end


end
