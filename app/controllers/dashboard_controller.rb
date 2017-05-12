class DashboardController < ApplicationController

  before_action :authenticate_user!
  include ApplicationHelper


  def index
    @jobs = current_user.jobs

    @jobs.each do |job|
      num_worked_days = job[:start_date].business_days_until(Date.current)
      hours_per_day = 8
      vacation_percentage = 0.04

      vacation_amount_earned = ((num_worked_days * hours_per_day) * job[:hourly_wage]) * vacation_percentage

      job[:vacation_amount] = vacation_amount_earned

      wage_per_day = hours_per_day * job[:hourly_wage]

      job[:vacation_days] = (vacation_amount_earned / wage_per_day).to_i

      job.save

    end
  end
end
