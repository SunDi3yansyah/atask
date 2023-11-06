class RootController < ActionController::API
  include ApplicationHelper

  include Response
  include StatusCode
  include Extras
  include ExceptionHandler unless Rails.env.development?
end
