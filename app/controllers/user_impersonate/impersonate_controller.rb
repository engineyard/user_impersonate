require_dependency "user_impersonate/application_controller"

module UserImpersonate
  class ImpersonateController < ApplicationController
    before_filter :authenticate_user!
    before_filter :staff_only!
    
    def index
      if params[:search]
        @users = User.where("name like ?", "%#{params[:search]}%")
      end
    end
    
    # Perform the user impersonate action
    def create
      redirect_to main_app.root_url
    end
    
    private
    def staff_only!
      unless current_user.respond_to?(:staff?) && current_user.staff?
        flash[:error] = "You don't have access to this section."
        redirect_to :back
      end
    end
  end
end
