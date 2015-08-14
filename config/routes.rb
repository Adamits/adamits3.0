Rails.application.routes.draw do

  devise_for :users

  root to: 'posts#index'

  resources :posts, only: ['index', 'show'] do
  	collection do
  	 get :search
  	end
  end

  namespace :admin do
    resources :posts do
      collection do
        get :update_all
      end
    end
  end

  resources :resumes, only: ['index']

end
