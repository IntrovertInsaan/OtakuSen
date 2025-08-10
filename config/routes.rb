Rails.application.routes.draw do
  get "explore/index"
  get "profiles/show"
  devise_for :users

  root "media_items#index"

  get "dashboard", to: "dashboard#index"

  resources :media_items do
    member do
      patch :increment_chapter
      patch :decrement_chapter
    end
  end

  get "explore", to: "explore#index"

  resources :profiles, only: [ :show ]
end
