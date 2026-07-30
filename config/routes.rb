Rails.application.routes.draw do
  namespace :madmin do
    resources :analyzed_files
    resources :reports
    root to: "dashboard#show"
  end
  root to: "pages#home"

  get "/pages/home", to: redirect("/", status: 301)

  post "/reports", to: "reports#create"
  get "/:id", to: "reports#show"
end
