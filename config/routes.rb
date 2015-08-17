Rails.application.routes.draw do

  devise_for :users, :skip => [:registrations]

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

  get '/resume', to: 'resumes#show'
  get '/about', to: 'abouts#show'

end
