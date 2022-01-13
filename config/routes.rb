Rails.application.routes.draw do
  devise_for :users
  root to: 'choices#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :choices, only: %i[index update]
end
