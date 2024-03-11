# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'passwords' }, skip: [:registrations]

  # Encapsulate your custom Devise routes within a devise_scope block
  devise_scope :user do
    get 'forgot_password', to: 'passwords#new', as: :forgot_password
    post 'forgot_password', to: 'passwords#create'
    get 'reset_password', to: 'passwords#edit', as: :reset_password
    get 'password_create_error', to: 'passwords#password_create_error'
  end

  root 'employees#index'
  resources :employees
  resources :departments
end
