Rails.application.routes.draw do

  devise_for :users
  match 'users/sign_up' => redirect('/404.html'), via: :all
  root to: 'posts#index'
  resources :posts, only: ['index', 'show']
  resources :searches, only: ['show']
  namespace :admin do
    resources :posts
  end
  
end