Rails.application.routes.draw do

  resources :albums
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  root 'home#index'
  get 'home/index'

end
