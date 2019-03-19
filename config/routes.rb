Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  Rails.application.routes.draw do
    namespace :api do
      namespace :v1 do
        mount_devise_token_auth_for 'User', at: 'auth'
        resources :movies, only: [:index, :show, :random_show]
        resources :ratings, only: [:index, :create]
      end
    end
  end
end
