Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  namespace :api do
    namespace :v1 do
      post 'facility_registrations', to: 'facility_registrations#create'

      resources :onsens, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json } do
        collection do
          post 'all'
          post 'my_onsen_book'
          get 'latest'
        end

        member do
          post 'toggle_my_onsen'
        end
      end
      resources :facilities, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json }
      resources :prefectures, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json }
      resources :facility_types, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json }

      mount_devise_token_auth_for 'User', at: 'auth'

      namespace :current do
        resource :user, only: [:show]
      end
    end
  end
end
