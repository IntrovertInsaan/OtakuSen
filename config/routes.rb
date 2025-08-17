# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" } # Updated in order to enter avatar and bio without entering passwords by custom registration controller.

  root "media_items#index"

  get "dashboard", to: "dashboard#index"

  resources :media_items do
    resources :notes, except: [ :show ] # We don't need a separate show page for one note

    member do
      patch :increment_chapter
      patch :decrement_chapter
      patch :favorite
      patch :unfavorite
    end

    collection do
      get :favorites
    end
  end

  resources :profiles, only: [ :show ] do
    # This creates a GET route for /profiles/:id/achievements
    get :achievements, on: :member
  end

  namespace :admin do
    get "dashboard/index"
    root "dashboard#index"
  end
end
