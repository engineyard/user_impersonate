Rails.application.routes.draw do

  mount UserTakeover::Engine => "/user_takeover"
end
