# frozen_string_literal: true

Rails.application.routes.draw do
  root controller: :users, action: :index

  devise_for :users

  resources :users, only: %i[index show edit update] do
    resources :followers, only: %i[create destroy]
    resources :stories, except: :show

    get :requests, :search, on: :collection

    resources :posts, except: :index, shallow: true do
      resources :likes, only: %i[create destroy], shallow: true
      resources :comments, except: %i[index show]
    end
  end
end
