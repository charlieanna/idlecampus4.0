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
<<<<<<< HEAD
      get 'get_group_code'

      get 'get_group_name'

=======
      
      get 'get_group_name'
      
>>>>>>> working
    end
  end
  resources :teachers
  resources :students
  resources :groups do
    resources :notes
  end
  resources :notes
  resources :alerts, only: [:new, :create]
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

<<<<<<< HEAD

  # get "timetable/create"
  #  post "timetable/create"
   # get "timetable/get_timetable_for_group"
   
<<<<<<< HEAD
   resource :timetable, only: [:create,:show]
=======
   # resource :timetable, only: [:create,:show]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
>>>>>>> working


=======
>>>>>>> working
end
