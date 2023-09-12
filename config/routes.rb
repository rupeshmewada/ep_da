Rails.application.routes.draw do

  # get "patients/name/:name" ,to:"patients#search_name"
  resources :appointments 

  resources :doctors ,:patients do 
    resources :appointments 
    get "area/:specilization" ,to:"doctors#area" , on: :collection    
    get "name/:name" ,to:"doctors#search_name" ,on: :collection 

  end

  resources :specializations
end