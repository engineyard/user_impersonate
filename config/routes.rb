UserImpersonate::Engine.routes.draw do
  match("/user/:user_id" , to: "impersonate#create", as: :impersonate_user)
  match("/revert" , to: "impersonate#destroy", as: :revert_impersonate_user)
  match("/user/:user_id/request" , to: "impersonate#new", as: :request_impersonate_user)
  root to: "impersonate#index"
end
