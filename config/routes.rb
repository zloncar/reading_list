Rails.application.routes.draw do
  namespace :api do
    resources :books
    resources :finished_books
    resources :genres
  end
end
