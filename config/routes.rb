Rails.application.routes.draw do
  constraints(Subdomain) do
    get '/' => 'blog/posts#index'
  end 
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :blogs

  namespace :blog do
    resources :posts
  end
end
