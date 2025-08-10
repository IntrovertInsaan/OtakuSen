Rails.application.routes.draw do
  get "dashboard", to: "dashboard#index"
  resources :media_items do
    member do
      patch :increment_chapter
      patch :decrement_chapter
    end
  end
  root "media_items#index"
end
