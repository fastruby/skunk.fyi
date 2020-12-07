Rails.application.routes.draw do
  root to: "high_voltage/pages#show", id: "home"

  post "/reports", to: "reports#create"
  get "/:id", to: "reports#show"
end
