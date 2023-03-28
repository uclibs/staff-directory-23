Rails.application.routes.draw do
  #root 'employees#index' # make the employees#index the root of the application
resources :employees

  resources :departments
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

