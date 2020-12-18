Rails.application.routes.draw do
  devise_for :users
  resources :questions, shallow: true do
    resources :answers, only: [:create, :destroy], shallow: true
  end

  root to: 'questions#index'
end
