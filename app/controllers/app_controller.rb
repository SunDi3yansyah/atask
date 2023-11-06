class AppController < ActionController::API
  include App::ApplicationHelper

  include Response
  include StatusCode
  include ExceptionHandler unless Rails.env.development?
  include App::ApplicationConcern
end
