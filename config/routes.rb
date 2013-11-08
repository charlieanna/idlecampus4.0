IdleCampus::Application.routes.draw do
  
  get "password_resets/new"
   

  match "checkEmail" => "user_validations#checkEmail",via: 'get'
  match "checkName" => "user_validations#checkName",via: 'get'
  
  post "users/frommobile"
  post "users/login"
  resources :users do 
    resources :groups
  end
  resources :groups do
    resource :timetable,only: [:create,:show]
    collection do
      
      get 'get_group_name'
      
    end
  end
  
  namespace :api do
     
       resources :users,only: :create
      
  end
  root  'static_pages#home'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signout',  to: 'sessions#destroy',            via: 'delete'
  match '/signin',  to: 'sessions#new',            via: 'get'
  match '/about',to: "static_pages#about",via: :get
  resources :messages, only: [:new, :create]
  match '/contact',to: "messages#new",via: :get
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  namespace :api do
    resources :users, only: [:create]
  end
  
  resources :password_resets

end
