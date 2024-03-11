# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'passwords' }, skip: [:registrations]
  # Custom routes for password reset
  get 'forgot_password', to: 'passwords#new'
  post 'forgot_password', to: 'passwords#create'
  get 'reset_password', to: 'passwords#edit'
  get 'password_create_error', to: 'passwords#password_create_error'

  root 'employees#index'
  # suggestion: get 'public/index'
  resources :employees
  resources :departments
end

