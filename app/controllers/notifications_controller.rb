class NotificationsController < ApplicationController
  after_action :clear_notifications, only: [:index]

  def index
    @notifications = Notification.all
    respond_to do |format|
      format.js
    end
  end

  private

  def clear_notifications
    Notification.destroy_all
  end
end
