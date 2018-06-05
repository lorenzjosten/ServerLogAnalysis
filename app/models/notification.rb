class Notification < ApplicationRecord
  include NotificationModule::CustomNotification
  serialize :notification, JSON
  validate :notification_class, on: :create

  private

  def notification_class
    errors.add(:notification, "Is not a valid notification") unless notification.is_a?(NotificationModule::CustomNotification)
  end
end
