Rails.application.routes.draw do

  root :to => "home#index"

  mount UserTakeover::Engine => "/takeover"
end
