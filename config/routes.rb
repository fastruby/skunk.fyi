Rails.application.routes.draw do
  namespace :madmin do
    resources :analyzed_files
    resources :reports
    root to: "dashboard#show"
  end
  root to: "high_voltage/pages#show", id: "home"

  post "/reports", to: "reports#create"
  get "/:id", to: "reports#show"
end
