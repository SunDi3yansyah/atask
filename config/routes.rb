Rails.application.routes.draw do
  namespace :app do
    resources :withdrawals
    resources :transfers
    resources :user_tokens
    resources :user_wallets
    resources :users
  end
end
