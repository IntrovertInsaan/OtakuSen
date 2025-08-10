Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" } # Updated in order to enter avatar and bio without entering passwords by custom registration controller.

  root "media_items#index"

  get "dashboard", to: "dashboard#index"

  resources :media_items do
    member do
      patch :increment_chapter
      patch :decrement_chapter
    end
  end

  resources :profiles, only: [ :show ]
end
