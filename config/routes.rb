# frozen_string_literal: true

Rails.application.routes.draw do
  get 'user/create'
  get 'user/update'
  get 'user/delete'
  devise_for :views
  devise_for :users
  # get 'departments/index'
  # get 'departments/show'
  # get 'departments/edit'
  # get 'departments/update'
  # get 'departments/new'
  # root 'employees#index' # make the employees#index the root of the application
  root 'employees#index'
  # suggestion: get 'public/index'
  resources :employees
  resources :departments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
