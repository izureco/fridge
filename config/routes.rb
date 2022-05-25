Rails.application.routes.draw do
  # アカウント編集後、任意のページに遷移させるための記述
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'boxes#index'
  resources :boxes, only: [:index, :new, :create, :show] do
    resources :foods, only: [:new, :create, :edit, :update, :show]
    # collection do
    #   get 'category'
    # end
  end
  
  resources :users, only: [:show]

end
