Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'devices#index'
  
  namespace :api, :defaults => {:format => :json} do
    resources :sensors
    resources :actuators
  end
  resources :sensor_actuators
  resources :commands
  resources :actuator_histories
  resources :actuators
  resources :sensor_histories
  resources :sensors
  resources :devices
  resources :variables
  resources :elements
end
