Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :onsens, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get 'all'
        end
      end
      resources :facilities, only: [:index, :show, :create, :update, :destroy] do
        collection do
          get 'all'
        end
      end
      resources :prefectures, only: [:index, :show, :create, :update, :destroy]
    end
  end
end
