AdamitsGov::Application.routes.draw do
  devise_for :users
  resources :posts

  resource :about, :only => [:show], :controller => 'about'
  resource :resume, :only => [:show], :controller => 'resume'
  root to: "home#index"
end
