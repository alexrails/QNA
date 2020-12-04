Rails.application.routes.draw do
  devise_for :users
  resources :questions do
    resources :answers, except: [:show, :new], shallow: true
  end

  root to: "questions#index"
end
