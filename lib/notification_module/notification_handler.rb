module NotificationModule
  module NotificationHandler
    def notify(notification)
      Notification.create({notification: notification})
    end
  end
end
