module NotificationModule
  class NoPlotDataWarning < Notification
    def initialize
      super(701, :data_error, "Could not find data to plot")
    end
  end
end
