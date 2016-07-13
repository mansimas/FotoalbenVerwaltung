Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :comments
  resources :albums
  devise_for :users, :controllers => { registrations: 'registrations' }
  
  root 'home#index'
  get 'home/index'
  post 'photos' => 'albums#add_photo'
  get 'image' => 'albums#image'

end
