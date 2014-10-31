Rails.application.routes.draw do

  resource :user, only: [:create, :new, :show]
  resource :session, only: [:create, :new, :destroy]
  resources :bands do
  	resources :albums, only: :new
  end

  resources :albums, except: [:new, :index] do
  	resources :tracks, only: :new
  end

  resources :tracks, except: [:new, :index] do
  	resources :notes, only: :new
  end
  resources :notes, except: [:new, :index, :edit, :update]
  root 'users#show'

end
