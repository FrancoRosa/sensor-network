Rails.application.routes.draw do
  resources :elements
  resources :actions
  resources :devices
  resources :variables
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
