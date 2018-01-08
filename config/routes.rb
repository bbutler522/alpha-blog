Rails.application.routes.draw do
  root 'pages#home'
  get 'about' => 'pages#about'
  
  get 'signup' => 'users#new'
  resources :users, except: [:new]
  
  resources :articles
end
