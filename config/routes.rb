Rails.application.routes.draw do
  namespace :madmin do
    resources :analyzed_files
    resources :reports
    root to: "dashboard#show"
  end
  root to: "pages#home"

  # high_voltage also registered `GET /pages/*id`, so /pages/home has been a live
  # URL. Kept as a redirect so any external link still resolves; removable once
  # the logs show nothing hits it.
  get "/pages/home", to: redirect("/", status: 301)

  post "/reports", to: "reports#create"
  get "/:id", to: "reports#show"
end
