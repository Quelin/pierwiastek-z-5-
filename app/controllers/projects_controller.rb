class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

    def index
      @projects = Project.all
    end

    def show
      @project = Project.find(params[:id])
    end

    def new
      @project = Project.new
      @clients = Client.all
      @project_count = Project.count + 1
    end

    def create
      @project = Project.new(project_params)

        if @project.save
          flash[:notice] = "Project was created successfully"
          redirect_to project_path(@project)
        else
          @clients = Client.all
          @project_count = Project.count + 1
          render('new')
        end
    end

    def edit
      @project = Project.find(params[:id])
      @clients = Client.all
      @project_count = Project.count
    end

    def update
      params[:project][:user_ids] ||= []
      @project = Project.find(params[:id])

      if @project.update_attributes(project_params)
        flash[:notice] = "Project was updated successfully"
        redirect_to(:action => 'show', :id => @project.id)
      else
        @clients = Client.all
        @project_count = Project.count
        render('edit')
      end
    end

    def delete
      @project = Project.find(params[:id])
    end

    def destroy
      @project = Project.find(params[:id])
      @project.destroy
      flash[:notice] = "Project was destroyed successfully"
      redirect_to(:action => 'index')
    end

  private
    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:name, :description, :client_id, {:user_ids => []})
    end
end
