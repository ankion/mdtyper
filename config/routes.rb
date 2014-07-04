Rails.application.routes.draw do
  constraints(Subdomain) do
    get '/' => 'blog/posts#index'
  end 

  root to: 'visitors#index'
  devise_for :users
  resources :users
  get 'blog/:subdomain/dashboard' => 'dashboard#index', :as => 'dashboard'
  resources :blogs do
    resources :posts
  end

end
