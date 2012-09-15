UserImpersonate::Engine.routes.draw do
  match("/user/:id" , to: "impersonate#create", as: :impersonate_user)
  
  root to: "impersonate#index"
end
