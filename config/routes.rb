Rails.application.routes.draw do
  get "dashboard", to: "dashboard#index"
  resources :media_items
  root "media_items#index"
end
