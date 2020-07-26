Rails.application.routes.draw do
  resources :tutor_sessions
  devise_for :users
  root "tutor_sessions#index"
end
