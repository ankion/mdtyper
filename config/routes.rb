Rails.application.routes.draw do
  constraints(Subdomain) do
    get '/' => 'blog/posts#index', :as => 'site_posts'
    get '/posts/:id' => 'blog/posts#show', :as => 'site_post'
  end 

  root to: 'visitors#index'
  devise_for :users
  resources :users
  get 'blog/dashboard' => 'dashboard#index', :as => 'dashboards'
  get 'blog/:subdomain/dashboard' => 'dashboard#index', :as => 'dashboard'
  resources :blogs do
    resources :posts
    resources :categories
  end

end
