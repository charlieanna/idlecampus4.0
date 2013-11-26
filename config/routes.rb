IdleCampus::Application.routes.draw do
  
 
  get "password_resets/new"
   

  match "checkEmail" => "user_validations#checkEmail",via: 'get'
  match "checkName" => "user_validations#checkName",via: 'get'
  
  post "users/frommobile"
  post "users/login"
   post "users/send_push"
  resources :users do 
    resources :groups
  end
  resource :home, only: :show
  resources :groups do
    resource :timetable,only: [:create,:show]
    collection do
      
      get 'get_group_name'
      
    end
  end
  match 'students/signup',  to: 'students#new',            via: 'get'
  match 'teachers/signup',  to: 'teachers#new',            via: 'get'
  resources :teachers
  resources :students
  resources :groups do
    resources :notes
  end
  resources :notes
  resources :alerts, only: [:new, :create]
  namespace :api do
    resources :users,only: :create
    resources :groups,only: :show
  end
  root  'homes#show'
 
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
