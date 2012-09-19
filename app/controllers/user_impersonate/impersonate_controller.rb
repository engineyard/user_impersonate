require_dependency "user_impersonate/application_controller"

module UserImpersonate
  class ImpersonateController < ApplicationController
    before_filter :authenticate_user!
    before_filter :current_user_must_be_staff!, except: ["destroy"]
    
    # Display list of all users, except current (staff) user
    # Is this exclusion unnecessary complexity?
    # Normal apps wouldn't bother with this action; rather they would
    # go straight to GET /impersonate/user/123 (create action)
    def index
      users_table = Arel::Table.new(user_table.to_sym) # e.g. :users
      id_column = users_table[user_id_column.to_sym]   # e.g. users_table[:id]
      @users = user_class.order("updated_at DESC").
                    where(
                      id_column.not_in [
                        current_user.send(user_id_column.to_sym) # e.g. current_user.id
                      ])
      if params[:search]
        @users = @users.where("name like ?", "%#{params[:search]}%")
      end
    end
    
    # Perform the user impersonate action
    # GET /impersonate/user/123 
    def create
      @user = find_user(params[:user_id])
      impersonate(@user)
      redirect_on_impersonate(@user)
    end
    
    # Revert the user impersonation
    # GET /impersonation/revert
    def destroy
      unless current_staff_user
        flash[:notice] = "You weren't impersonating anyone"
        redirect_on_revert and return
      end
      user = current_user
      revert_impersonate
      if user
        flash[:notice] = "No longer impersonating #{user}"
        redirect_on_revert(user)
      else
        flash[:notice] = "No longer impersonating a user"
        redirect_on_revert
      end
    end
    
    private
    def current_user_must_be_staff!
      unless user_is_staff?(current_user)
        flash[:error] = "You don't have access to this section."
        redirect_to :back
      end
    rescue ActionController::RedirectBackError
      redirect_to '/'
    end

    # Helper to load a User, using all the UserImpersonate config options
    def find_user(id)
      user_class.send(user_finder_method, id)
    end
    
    # Similar to user.staff?
    # Using all the UserImpersonate config options
    def user_is_staff?(user)
      current_user.respond_to?(user_is_staff_method.to_sym) &&
        current_user.send(user_is_staff_method.to_sym)
    end

    def user_finder_method
      (UserImpersonate::Engine.config.try(:user_finder) || "find").to_sym
    end

    def user_class_name
      UserImpersonate::Engine.config.try(:user_class) || "User"
    end

    def user_class
      user_class_name.constantize
    end
    
    def user_table
      user_class_name.tableize
    end
    
    def user_id_column
      UserImpersonate::Engine.config.try(:user_id_column) || "id"
    end
    
    def user_is_staff_method
      UserImpersonate::Engine.config.try(:user_is_staff_method) || "staff?"
    end
    
    def redirect_on_impersonate(impersonated_user)
      url = UserImpersonate::Engine.config.try(:redirect_on_impersonate) || main_app.root_url
      redirect_to url
    end
    
    def redirect_on_revert(impersonated_user = nil)
      url = UserImpersonate::Engine.config.redirect_on_revert || root_url
      redirect_to url
    end
  end
end
