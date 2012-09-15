Rails.application.routes.draw do

  devise_for :users

  root :to => "home#index"

  mount UserImpersonate::Engine => "/impersonate", as: "impersonate_engine"
end
