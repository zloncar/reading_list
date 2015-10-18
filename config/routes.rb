Rails.application.routes.draw do
  resources :books, only: [:index, :create, :show]
  resources :finished_books
end
