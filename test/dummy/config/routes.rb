Rails.application.routes.draw do

  devise_for :users

  root :to => "home#index"

  mount UserTakeover::Engine => "/takeover", as: "takeover_engine"
end
