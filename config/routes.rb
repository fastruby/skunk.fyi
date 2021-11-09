Rails.application.routes.draw do
  namespace :madmin do
    resources :analyzed_files
    resources :reports
    root to: "dashboard#show"
  end
  root to: "high_voltage/pages#show", id: "home"

  resources :github, only: [:new, :create, :show], constraints: { id: /[0-9a-zA-Z\/]+/ }
  resources :projects, only: [:create]

  post "/reports", to: "reports#create"
  get "/:id", to: "reports#show"
end
