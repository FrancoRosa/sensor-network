Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'devices#index'
  
  namespace :api, defaults: { format: :json } do
    resources :sensors, only: [:index]
    resources :actuators, only: [:index]
  end

  resources :sensor_actuators
  resources :commands
  resources :actuator_histories
  resources :sensor_histories
  resources :variables
  resources :elements

  resources :devices
  resources :sensors
  resources :actuators
end
