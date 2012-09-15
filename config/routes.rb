UserImpersonate::Engine.routes.draw do
  match("/user/:user_id" , to: "impersonate#create", as: :impersonate_user)
  match("/revert" , to: "impersonate#delete", as: :revert_impersonate_user)
  
  root to: "impersonate#index"
end
