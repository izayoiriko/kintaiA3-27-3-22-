Rails.application.routes.draw do

  root 'static_pages#top'
  get '/signup', to: 'users#new'

  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :bases
  resources :users do 
    collection { post :import }
    member do
      get 'index_employees'
      get 'edit_over_time'
      patch 'update_over_time'
      get 'edit_basic_ad'
      patch 'update_basic_ad'
      get 'edit_basic_info'
      patch 'update_basic_info'
      get 'attendances/edit_one_month'
      patch 'attendances/update_one_month'
    end
    resources :attendances, only: :update
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
