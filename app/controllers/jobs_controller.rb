class JobsController < ApplicationController

  def index
    @jobs = current_user.jobs
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user_id = current_user[:id]

    if @job.save
      redirect_to jobs_path, notice: "Job saved successfully."
    else
      render 'new'
    end
  end

  def edit
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(job_params)
        format.html { redirect_to jobs_path, notice: "Updated Job #{@job.title}" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy

    redirect_to @job, notice: "Job successfully deleted."
  end

  private

  def job_params
    params.require(:job).permit(:title, :company, :start_date, :hourly_wage)
  end
end
