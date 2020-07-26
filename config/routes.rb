Rails.application.routes.draw do

  patch "profiles/:id", to: "profiles#update", as: 'profile'
  get 'profiles/:id/edit', to: "profiles#edit", as: "edit_profile"
  get 'settings/notifications'
  get 'settings/close_account'
  resources :tutor_sessions
  devise_for :users, controllers: {registrations: 'registrations'}
  root "tutor_sessions#index"
end
