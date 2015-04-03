module Admin
  class UsersController < ApplicationController
    before_action :authorize_user

    def index
      @users = User.all.order(:created_at)
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted"
    end
  end
end
