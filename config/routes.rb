Rails.application.routes.draw do
  devise_for :users
  resources :requests do
    resources :comments , :controller => "request_comments"
  end

  root :to => "requests#index"
end
