class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

    def index

      if params[:project_id]
      @projects = Project.all
      temp = params[:project_id]
      id = temp["project_id"]
      @posts = Project.find(id).posts
      else
      @posts = Post.order("created_at DESC")
      @projects = Project.all
      end

    end

    def show
      @post = Post.find(params[:id])
    end

    def new
      @post = Post.new
      @projects = Project.all
      @post_count = Post.count + 1
    end

    def create
      @post = Post.new(post_params)

        if @post.save
          flash[:notice] = "Post was created successfully"
          redirect_to(:action => 'index')
        else
          @projects = Project.all
          @post_count = Post.count + 1
          render('new')
        end
    end

    def edit
      @post = Post.find(params[:id])
      @projects = Project.all
      @post_count = Post.count
    end

    def update
      @post = Post.find(params[:id])

      if @post.update_attributes(post_params)
        flash[:notice] = "Post was updated successfully"
        redirect_to(:action => 'show', :id => @post.id)
      else
        @projects = Project.all
        @post_count = Post.count
        render('edit')
      end
    end

    def delete
      @post = Post.find(params[:id])
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      flash[:notice] = "Post was destroyed successfully"
      redirect_to(:action => 'index')
    end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :project_id, :user_id, :count)
    end
end
