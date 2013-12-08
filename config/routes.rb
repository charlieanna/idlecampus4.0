IdleCampus::Application.routes.draw do
  
 
  get "password_resets/new"
  get "push/create"
  resources :password_resets
  match "checkEmail" => "user_validations#checkEmail",via: 'get'
  match "checkName" => "user_validations#checkName",via: 'get'
  
  post "users/frommobile"
  post "users/login"
   post "users/send_push"
  resources :users,except: :index 
  resource :home, only: :show
  resources :groups do
    resource :timetable,only: [:create,:show]
    resources :notes
    resources :files,only: :index
  end
  match 'students/signup',  to: 'students#new',            via: 'get'
  match 'teachers/signup',  to: 'teachers#new',            via: 'get'
  resources :teachers
  resources :students
  
  resource :push,only: :create
 
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
  match 'contact' => 'contact#new', :via => :get
  match 'contact' => 'contact#create',:via => :post
  
  resources :sessions, only: [:new, :create, :destroy]
  namespace :api do
    resources :users, only: [:create]
  end
  
  resources :password_resets
  
end
