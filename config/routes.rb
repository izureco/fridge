Rails.application.routes.draw do
  # アカウント編集後、任意のページに遷移させるための記述
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'boxes#index'
  resources :boxes, only: [:index, :new, :create, :show, :edit, :update] do
    resources :foods, only: [:new, :create,]
  end
  
  resources :users, only: [:show]

end
