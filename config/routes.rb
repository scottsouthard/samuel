Rails.application.routes.draw do
  root to: 'posts#index'

  get 'posts/upcoming' => "posts#upcoming"
  get 'posts/past' => "posts#past"
  resources :posts

  get 'welcome/about' => "welcome#about"

  get 'sessions/new' => "sessions#new"
  post 'sessions/create' => "sessions#create"
  get 'sessions/logout' => "sessions#logout"


end
