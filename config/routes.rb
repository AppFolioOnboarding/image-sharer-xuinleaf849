Rails.application.routes.draw do
  root 'images#index'
  resources :images, only: %i[index new create show destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root 'application#home'
end
