class UserImpersonateGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  def engine_routes
    route 'mount UserImpersonate::Engine => "/impersonate", as: "impersonate_engine"'
  end
  
  def configuration
    directory "config"
  end
  
  def views
    directory "app/views"
  end
end
