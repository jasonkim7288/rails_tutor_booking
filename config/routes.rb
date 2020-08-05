Rails.application.routes.draw do
  # namespace :user do
    get 'profiles/:id/edit', to: 'profiles#edit', as: 'edit_profile'
    patch 'profiles/:id', to: 'profiles#update', as: 'profile'
  # end

  get 'tutor_sessions/search_result', to: 'tutor_sessions#search_result', as: 'search_tutor_session'
  get 'tutor_sessions/my_attend_list'
  get 'tutor_sessions/my_tutor_sessions'
  get 'tutor_sessions/:id/attend', to: 'tutor_sessions#attend', as: 'attend_tutor_session'
  delete 'tutor_sessions/:id/cancel_attend', to: 'tutor_sessions#cancel_attend', as: 'cancel_attend_tutor_session'
  resources :tutor_sessions
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :tutor_sessions do
    resources :comments
  end
  root 'tutor_sessions#index'
end
