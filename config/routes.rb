Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, only: [:new, :create], shallow: true
  end

  root to: "questions#index"
end
