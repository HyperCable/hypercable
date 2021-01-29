# frozen_string_literal: true

Rails.application.routes.draw do
  root "sessions#new"
  resources :sessions, only: [:create, :new]
  resources :registrations, only: [:create, :new]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
