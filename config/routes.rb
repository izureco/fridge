Rails.application.routes.draw do
  devise_for :users
  root to: 'fridges#index'
end
