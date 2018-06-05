class Timeframe < ApplicationRecord
  include ActiveModel::AttributeMethods
  belongs_to :analysis

  validate :start_is_a_date, :end_is_a_date
  validate :start_before_end, :end_after_start

  attribute_method_suffix '_is_a_date?'
  attr_reader :start, :end

  def start_dt=(start_dt_params)
    date = start_dt_params[:date]
    time = start_dt_params[:time]
    self.start = DateTime.parse(date+' '+time)
  end

  def end_dt=(end_dt_params)
    date = end_dt_params[:date]
    time = end_dt_params[:time]
    self.end = DateTime.parse(date+' '+time)
  end

  private

  def start_is_a_date
    errors.add(:start, 'Start date must not be empty') unless start_is_a_date?
  end

  def end_is_a_date
    errors.add(:end, 'End date must not be empty') unless end_is_a_date?
  end

  def start_before_end
    errors.add(:start, 'Start date must not be later than end date') if self.start > self.end
  end

  def end_after_start
    errors.add(:end, 'End date must not be before than start date') if self.end < self.start
  end

  def attribute_is_a_date?(attribute)
    send(attribute).is_a?(Date)
  end

end
