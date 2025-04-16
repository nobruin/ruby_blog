Rails.application.routes.draw do
  get "pages/about"
  get "pages/contact"
  devise_for :users
  resources :blog_posts
  root "blog_posts#index"
end
