Rails.application.routes.draw do
  devise_for :users
  root to: 'boxes#index'
  resources :boxes, only: [:index, :new, :create, :show] do
    resources :foods, only: [:new, :create, :edit, :update, :show]
    # collection do
    #   get 'category'
    # end
  end
  
  resources :users, only: [:show]
end
