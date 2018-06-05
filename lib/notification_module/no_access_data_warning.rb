module NotificationModule
  class NoAccessDataWarning < Notification
    def initialize
      super(702, :data_error, "No processable data found in selected file")
    end
  end
end
