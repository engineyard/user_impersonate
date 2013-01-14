module UserImpersonate
  class Engine < Rails::Engine
    config.user_class           = "User"
    config.user_finder          = "find"   # User.find
    config.user_id_column       = "id"     # Such that User.find(aUser.id) works
    config.user_is_staff_method = "staff?" # current_user.staff?
    config.search_column  = "name" # Such that User.where("name like ?", search_value) works
    
    config.redirect_on_impersonate = "/"
    config.redirect_on_revert = "/impersonate"

    config.authenticate_user_method = "authenticate_user!" # protect impersonation controller
    config.sign_in_user_method      = "sign_in"            # sign_in(user)
  end
end
