Rails.application.routes.draw do
  root to: 'choices#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resource :choices, only: %i[index update]
end
