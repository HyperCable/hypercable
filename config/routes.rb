# frozen_string_literal: true

Rails.application.routes.draw do
  root "sessions#new"
  resources :sessions, only: [:create, :new]
  delete "sign_out", to: "sessions#destroy", as: :destroy_session
  resources :registrations, only: [:create, :new] do
    collection do
      get "verification"
      get "verify"
    end
  end
  resources :sites do
    resources :location_urls, only: [:index]
    resources :countries, only: [:index]
    resources :referrer_sources, only: [:index]
    resources :traffic_mediums, only: [:index]
    resources :traffic_sources, only: [:index]
    resources :traffic_campaigns, only: [:index]
    resources :browsers, only: [:index]
    resources :device_types, only: [:index]
    resources :oses, only: [:index]

    resources :site_connections, only: [:index, :new, :show, :destroy, :create]
    resources :measurement_protocols, only: [:index, :new, :show, :destroy, :create]
    member do
      get "snippet"
      get "debug"
    end
    resources :settings, only: %i[index] do
      collection do
        get "general"
        patch "update_general"
      end

      collection do
        get "visibility"
        patch "update_visibility"
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
