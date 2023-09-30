Rails.application.routes.draw do
  devise_for :admins

  devise_scope :admin do
    get "/admins/sign_out" => "devise/sessions#destroy"
  end

  root 'doctors#index'

  # get "patients/name/:name" ,to:"patients#search_name"
  
  resources :appointments 
  resources :tests 
  get "doctors/:id/doctor_all_appointmentent" ,to:"doctors#doctor_all_appointmentent"
  get "doctors/:id/doc_pat" ,to:"doctors#doc_pat"

  get "/doctors/search", to: "doctors#search"
  resources :doctors ,:patients do 
    
    post "appointments/pat_create"  
    resources :appointments 
    get "area/:specilization" ,to:"doctors#area" , on: :collection    
    get "name/:name" ,to:"doctors#search_name" ,on: :collection 
    get "city_search/:location" ,to:"doctors#city_search" ,on: :collection 
    
  end

  post '/auth/login', to: 'authentications#login'
  get '/*a', to: 'application#not_found'

  # resources :users, param: :_username
  # post '/auth/login', to: 'authentication#login'
  # get '/*a', to: 'application#not_found'

  get "/doctors/:id/image", to: "doctors#image"

  resources :specializations
end