class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include App::ApplicationHelper
end
