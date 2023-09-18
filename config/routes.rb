Rails.application.routes.draw do
  get 'tests/index'

  # get "patients/name/:name" ,to:"patients#search_name"
  resources :appointments 
  resources :tests 
  
  get "/doctors/search", to: "doctors#search"
  resources :doctors ,:patients do 
    resources :appointments 
    get "area/:specilization" ,to:"doctors#area" , on: :collection    
    get "name/:name" ,to:"doctors#search_name" ,on: :collection 
    get "city_search/:location" ,to:"doctors#city_search" ,on: :collection 
    
  end
  get "/doctors/:id/image", to: "doctors#image"

  resources :specializations
end