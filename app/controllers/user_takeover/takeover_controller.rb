require_dependency "user_takeover/application_controller"

module UserTakeover
  class TakeoverController < ApplicationController
    def index
      if params[:search]
        @users = User.where("name like ?", "%#{params[:search]}%")
      end
    end
    
    # Perform the user takeover action
    def create
      redirect_to main_app.root_url
    end
  end
end
