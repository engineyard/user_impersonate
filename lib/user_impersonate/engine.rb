require 'rack/session/abstract/id'
module UserImpersonate
  class Engine < ::Rails::Engine
    isolate_namespace UserImpersonate
    
    initializer "user_impersonate.rack_session_ext" do |app|
      Rack::Session::Abstract::SessionHash.class_eval do
        include UserImpersonate::RackSessionExt
      end
    end
  end
end
