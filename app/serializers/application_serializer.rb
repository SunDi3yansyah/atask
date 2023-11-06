class ApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  include ApplicationHelper

  default_url_options[:host] = ENV['HOST_APP_BACKEND']

  # attribute :method_name do
  #   Module::V1::ClassSerializer.new(object.method_name).as_json unless object.method_name.nil?
  # end

  # Call with options
  # @instance_options&.[](:options)&.[](:key_name)
end
