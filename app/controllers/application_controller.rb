class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ErrorModule
  include ErrorModule::ErrorHandler
  include NotificationModule
end
