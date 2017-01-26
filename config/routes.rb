Rails.application.routes.draw do

  root to: "pages#home"

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :accounts, controllers: {
    sessions: "devise_overrides/sessions",
    registrations: "devise_overrides/registrations"
  }

  resources :posts do
    collection do
      get :search
    end
  end
  resources :user, only: [:edit, :update, :show] do
    member do
      post :follow
      delete :unfollow
      delete :delete_image
      resource :posts, only: [] do
        get :drafts
        get :published, on: :collection
      end
    end
  end
end
