Rails.application.routes.draw do
  devise_for :users
  root to: 'boxes#index'
  resources :boxes, only: [:index, :new, :create] do
    resources :foods, only: [:new, :create]
  end
end
