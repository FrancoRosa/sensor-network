Rails.application.routes.draw do
  resources :actuators
  resources :sensor_histories
  resources :sensors
  resources :devices
  resources :variables
  resources :elements
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
