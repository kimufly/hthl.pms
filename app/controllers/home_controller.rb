class HomeController < ApplicationController

  def index 
    @tech_hours = nil
    if params[:graduation_day]
      among_time = params[:graduation_day].gsub(' ','').split("-")
      start_time = among_time[0].to_time.beginning_of_day
      end_time = among_time[1].to_time.at_end_of_day
      @tech_hours = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', start_time, end_time).group('date(tech_hours.start_at)').order('start_at ASC')    

    else
      if params[:type].eql? "week"
        #本周
        @tech_hours = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.at_beginning_of_week, Time.now.at_end_of_week).group('date(tech_hours.start_at), users.price').order('start_at ASC')
      elsif params[:type].eql? "month"
        #本月
        @tech_hours =TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.beginning_of_month, Time.now.end_of_month).group('date(tech_hours.start_at), users.price').order('start_at ASC')
      elsif params[:type].eql? "quarter"
        #本季度
        @tech_hours =TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.beginning_of_quarter, Time.now.end_of_quarter).group('date(tech_hours.start_at), users.price').order('start_at ASC')
      else
        #默认本周
        @tech_hours = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.at_beginning_of_week, Time.now.at_end_of_week).group('date(tech_hours.start_at), users.price').order('start_at ASC')
      end
    end
    
    @result_date = Array.new
    @result_time = Array.new
    for tech_hours in @tech_hours
      @result_date.push(tech_hours.time_limit)
      @result_time.push(tech_hours.start_at.strftime('%Y-%m-%d'))
    end
    @comparison_month = format("%.2f",current_month_comparison_last_month()[0]).to_f  
    @comparison_week = format("%.2f",current_week_comparison_last_week()[0]).to_f  
    @current_month = format("%.2f",current_month_comparison_last_month()[1]).to_f  
    @current_week = format("%.2f",current_week_comparison_last_week()[1]).to_f 
    
    @projects = Project.all
    @project_top_5 = ProjectUser.left_outer_joins(:project, :user).distinct.select('COUNT(project_users.id), project_users.project_id, COUNT(projects.time_limit * users.price) AS project_count').group('project_users.id, project_users.project_id').order('project_count DESC').first(5)
  end


  def current_month_comparison_last_month()
    sum_current_month_cost = 0
    sum_last_month_cost = 0
    @current_month = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.beginning_of_month, Time.now.end_of_month).group('date(tech_hours.start_at), users.price').order('start_at ASC')
    @last_month = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', (Time.now - 1.month).beginning_of_month, (Time.now - 1.month).end_of_month).group('date(tech_hours.start_at), users.price').order('start_at ASC')
    for tech_hours in @current_month
      sum_current_month_cost += tech_hours.time_limit
    end
    for tech_hours in @last_month
      sum_last_month_cost += tech_hours.time_limit
    end
    arr_month=  @result_date = Array.new
    arr_month.push((sum_current_month_cost - sum_last_month_cost) / sum_last_month_cost * 100)
    arr_month.push(sum_current_month_cost)
    return arr_month
  end


  def current_week_comparison_last_week()
    sum_current_week_cost = 0
    sum_last_week_cost = 0
    @current_week = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', Time.now.at_beginning_of_week, Time.now.at_end_of_week).group('date(tech_hours.start_at), users.price').order('start_at ASC')
    @last_week = TechHour.left_outer_joins(:user).distinct.select('(SUM(tech_hours.time_limit) * users.price) AS time_limit, date(tech_hours.start_at) AS start_at').where('start_at >= ? AND start_at <= ?', (Time.now - 1.week).at_beginning_of_week, (Time.now - 1.week).at_end_of_week).group('date(tech_hours.start_at), users.price').order('start_at ASC')
    for tech_hours in @current_week
      sum_current_week_cost += tech_hours.time_limit
    end
    for tech_hours in @last_week
      sum_last_week_cost += tech_hours.time_limit
    end
    arr_week =  @result_date = Array.new
    arr_week.push((sum_current_week_cost - sum_last_week_cost) / sum_last_week_cost * 100 / 10)
    arr_week.push(sum_current_week_cost)
    return arr_week
  end


end
