class UsersController < ApplicationController
  	def index
  		@users = User.all
  	end
      def show
      @user = User.find(params[:id])
    end

    def delete
      @user = User.find(params[:id])
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "User was destroyed successfully"
      redirect_to(:action => 'index')
    end



end
