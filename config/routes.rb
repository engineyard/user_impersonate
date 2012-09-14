UserTakeover::Engine.routes.draw do
  match("/user/:id" , to: "takeover#create", as: :takeover_user)
  
  root to: "takeover#index"
end
