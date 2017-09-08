Rails.application.routes.draw do
  root 'secrets#new'

  resources :secrets, only: [:create, :new, :show]
end
