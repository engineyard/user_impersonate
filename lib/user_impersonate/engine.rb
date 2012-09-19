module UserImpersonate
  class Engine < ::Rails::Engine
    isolate_namespace UserImpersonate
    
    initializer "user_impersonate.devise_helpers" do
      if Object.const_defined?("Devise")
        require "user_impersonate/devise_helpers"
        Devise.include_helpers(UserImpersonate::DeviseHelpers)
      end
    end

    # also duplicated in generator initializer
    initializer "user_impersonate.default_config" do
      config.user_class           = "User"
      config.user_finder          = "find"   # User.find
      config.user_id_column       = "id"     # Such that User.find(aUser.id) works
      config.user_is_staff_method = "staff?" # current_user.staff?
    end
  end
end
