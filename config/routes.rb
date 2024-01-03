Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'facility_registrations', to: 'facility_registrations#create'

      resources :onsens, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json } do
        collection do
          get 'all'
        end
      end
      resources :facilities, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json }
      resources :prefectures, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json }
      resources :facility_types, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json }
    end
  end
end
