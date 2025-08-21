# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users/registrations" }

  root "media_items#index"

  get "dashboard", to: "dashboard#index"

  resources :media_items do
    resources :notes, except: [ :show ]

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
    get :achievements, on: :member
  end

  namespace :admin do
    get "dashboard/index"
    root "dashboard#index"
  end

  resources :forum_threads, only: [ :index, :show, :new, :create ] do
    resources :forum_posts, only: [ :create, :edit, :update, :destroy ]
  end
end
