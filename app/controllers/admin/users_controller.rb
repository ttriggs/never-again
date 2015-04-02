module Admin
  class UsersController < ApplicationController
    before_action :authorize_user

    def index
      @users = User.all
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: "User deleted"
    end

    def authorize_user
      unless user_signed_in? && current_user.admin?
        raise ActionController::RoutingError.new("Not Found")
      end
    end
  end
end
