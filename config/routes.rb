UserImpersonate::Engine.routes.draw do
  match("/user/:user_id" , to: "impersonate#create", as: :impersonate_user)
  
  root to: "impersonate#index"
end
