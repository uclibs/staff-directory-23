# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { passwords: 'passwords' }, skip: [:registrations]
  # Custom routes for password reset
  get 'forgot_password', to: 'passwords#new'
  post 'forgot_password', to: 'passwords#create'
  get 'reset_password', to: 'passwords#edit'

  # root 'employees#index' # make the employees#index the root of the application
  root 'employees#index'
  # suggestion: get 'public/index'
  resources :employees
  resources :departments
end
