module UserImpersonate
  class Engine < ::Rails::Engine
    isolate_namespace UserImpersonate
    
    # initializer "user_impersonate.rack_session_ext" do |app|
    # require 'rack/session/abstract/id'
    #   Rack::Session::Abstract::SessionHash.class_eval do
    #     include UserImpersonate::RackSessionExt
    #   end
    # end

    initializer "user_impersonate.devise_helpers" do
      if Object.const_defined?("Devise")
        require "user_impersonate/devise_helpers"
        Devise.include_helpers(UserImpersonate::DeviseHelpers)
      end
    end
  end
end
