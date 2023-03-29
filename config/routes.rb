Rails.application.routes.draw do
  get 'departments/index'
  get 'departments/show'
  get 'departments/edit'
  get 'departments/update'
  #root 'employees#index' # make the employees#index the root of the application
  root  'employees#index'
  #suggestion: get 'public/index'
  resources :employees
  resources :departments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

