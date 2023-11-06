Rails.application.routes.draw do
  root 'root#index', format: 'json'

  match '404', to: 'root#status_code_404', as: :status_code_404, via: :all, format: 'json'
  match '422', to: 'root#status_code_422', as: :status_code_422, via: :all, format: 'json'
  match '500', to: 'root#status_code_500', as: :status_code_500, via: :all, format: 'json'
  match 'exception', to: 'root#exception', as: :exception, via: :all, format: 'json'

  get 'http-status', to: 'root#http_status', format: 'json'

  mount ActionCable.server => '/cable'

  require 'sidekiq/web'
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: '_interslice_session'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
  end if Rails.env.production? || Rails.env.staging?
  mount Sidekiq::Web, at: '/sidekiq'

  namespace :app, defaults: { format: 'json' } do
    namespace :account do
      post 'sign-in', to: 'sign_in#create'
    end
    resources :users, only: [:index, :show]
    resources :user_tokens, path: 'user-tokens', only: []
    resources :user_wallets, path: 'user-wallets', only: [:index, :show]
    resources :transfers, only: [:index, :show, :create]
    resources :withdrawals, only: [:index, :show, :create]
  end
end
