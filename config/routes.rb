Rails.application.routes.draw do
  devise_for :users

  root "media_items#index"

  get "dashboard", to: "dashboard#index"

  resources :media_items do
    member do
      patch :increment_chapter
      patch :decrement_chapter
    end
  end
end
