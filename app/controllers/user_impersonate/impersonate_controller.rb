require_dependency "user_impersonate/application_controller"

module UserImpersonate
  class ImpersonateController < ApplicationController
    before_filter :authenticate_the_user
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
        @users = @users.where("#{user_name_column} like ?", "%#{params[:search]}%")
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
    # DELETE /impersonation/revert
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

    # current_user changes from a staff user to
    # +new_user+; current user stored in +session[:staff_user_id]+
    def impersonate(new_user)
      session[:staff_user_id] = current_user.id #
      sign_in_user new_user
    end

    # revert the +current_user+ back to the staff user
    # stored in +session[:staff_user_id]+
    def revert_impersonate
      return unless current_staff_user
      sign_in_user current_staff_user
      session[:staff_user_id] = nil
    end

    def sign_in_user(user)
      method = config_or_default :sign_in_user_method, "sign_in"
      self.send(method.to_sym, user)
    end

    def authenticate_the_user
      method = config_or_default :authenticate_user_method, "authenticate_user!"
      self.send(method.to_sym)
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
      (config_or_default :user_finder, "find").to_sym
    end

    def user_class_name
      config_or_default :user_class, "User"
    end

    def user_class
      user_class_name.constantize
    end

    def user_table
      user_class_name.tableize.tr('/', '_')
    end

    def user_id_column
      config_or_default :user_id_column, "id"
    end

    def user_name_column
      config_or_default :user_name_column, "name"
    end

    def user_is_staff_method
      config_or_default :user_is_staff_method, "staff?"
    end

    def redirect_on_impersonate(impersonated_user)
      url = config_or_default :redirect_on_impersonate, root_url
      redirect_to url
    end

    def redirect_on_revert(impersonated_user = nil)
      url = config_or_default :redirect_on_revert, root_url
      redirect_to url
    end

    # gets overridden config value for engine, else returns default
    def config_or_default(attribute, default)
      attribute = attribute.to_sym
      if UserImpersonate::Engine.config.respond_to?(attribute)
        UserImpersonate::Engine.config.send(attribute)
      else
        default
      end
    end
  end
end
