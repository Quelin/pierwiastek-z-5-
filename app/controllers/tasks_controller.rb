class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

 def index
    project = Project.find(params[:project_id])
    @tasks = project.tasks

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @tasks }
      format.json 
    end
  end


  def show
    project = Project.find(params[:project_id])
    @task = project.tasks.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @task }
      format.json
    end
  end

  def new
    project = Project.find(params[:project_id])
    @task = project.tasks.build
    @users = project.users

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @task }
    end
  end


  def edit
    project = Project.find(params[:project_id])
    @task = project.tasks.find(params[:id])
    @users = project.users
  end

  def create
    project = Project.find(params[:project_id])
    @task = project.tasks.create(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to([@task.project, @task], :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => [@task.project, @task] }
      else
        @users = project.users
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    project = Project.find(params[:project_id])
    @task = project.tasks.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(task_params)
        format.html { redirect_to([@task.project, @task], :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        @users = project.users
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    project = Project.find(params[:project_id])
    @task = project.tasks.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(project_tasks_url) }
      format.xml  { head :ok }
    end
  end

  def show_all
    @tasks = Task.all
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @tasks }
      format.json 
    end
  end

  def start
    @task = Task.find(params[:id])
    @activity = Activity.create(task: @task, start_time: Time.now)
    redirect_to [@task.project, @task]
  end

  def stop
    @task = Task.find(params[:id])
    @activity = @task.activities.last.update(end_time: Time.now)
    redirect_to [@task.project, @task]
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :description, :done, :start_time, :end_time, :project_id, :user_id, :milestone_id)
    end

end