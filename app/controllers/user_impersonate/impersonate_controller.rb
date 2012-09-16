require_dependency "user_impersonate/application_controller"

module UserImpersonate
  class ImpersonateController < ApplicationController
    before_filter :authenticate_user!
    before_filter :current_user_must_be_staff!, except: ["destroy"]
    
    def index
      users_table = Arel::Table.new(:users)
      @users = User.order("updated_at DESC").
                    where(users_table[:id].not_in [current_user.id])
      if params[:search]
        @users = @users.where("name like ?", "%#{params[:search]}%")
      end
    end
    
    # Perform the user impersonate action
    def create
      @user = User.find(params[:user_id])
      impersonate(@user)
      redirect_to main_app.root_url
    end
    
    # Revert the user impersonation
    def destroy
      unless current_staff_user
        flash[:notice] = "You weren't impersonating anyone"
        redirect_to main_app.root_url and return
      end
      user = current_user
      revert_impersonate
      if user
        flash[:notice] = "No longer impersonating #{user.name}"
        redirect_to main_app.root_url
      else
        flash[:notice] = "No longer impersonating a user"
        redirect_to main_app.root_url
      end
    end
    
    private
    def current_user_must_be_staff!
      unless current_user.respond_to?(:staff?) && current_user.staff?
        flash[:error] = "You don't have access to this section."
        redirect_to :back
      end
    end
  end
end
