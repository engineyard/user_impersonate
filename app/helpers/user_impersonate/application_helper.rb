module UserImpersonate
  module ApplicationHelper
    def current_staff_user
      return unless session[:staff_user_id]
      user_finder_method = (UserImpersonate::Engine.config.user_finder || "find").to_sym
      user_class_name = UserImpersonate::Engine.config.user_class || "User"
      user_class = user_class_name.constantize
      @staff_user ||= user_class.send(user_finder_method, session[:staff_user_id])
    end

    def current_user_impersonated
      current_user_method_name = UserImpersonate::Engine.config.current_user_method || "current_user"
      send(current_user_method_name)
    end
  end
end
