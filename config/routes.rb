IdleCampus::Application.routes.draw do
  
  get "sessions/index"
  
  match "users/checkEmail" => "users#checkEmail",via: 'get'
  get "users/checkName"
  get "users/new1"
  resources :users
  resources :groups do
    resource :timetable
    collection do
      get 'get_group_code'

      get 'get_group_name'

    end
  end
  root  'static_pages#home'

  match '/signup',  to: 'users#new',            via: 'get'
  match '/signout',  to: 'sessions#destroy',            via: 'delete'
  match '/signin',  to: 'sessions#new',            via: 'get'
  resources :users
  resources :sessions, only: [:new, :create, :destroy]


  # get "timetable/create"
  #  post "timetable/create"
   get "timetable/get_timetable_for_group"
   
   resource :timetable, only: [:create,:show]


end
