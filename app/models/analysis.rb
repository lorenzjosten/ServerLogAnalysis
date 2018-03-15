class Analysis < ApplicationRecord
  model_name.instance_variable_set(:@route_key, 'analysis')

  has_one :input_file, dependent: :destroy
  has_one :timeframe, dependent: :destroy

  validates_presence_of :input_file
  validates_presence_of :timeframe
  before_validation :build_default_input_file, :build_default_timeframe

  private

  def build_default_input_file
    build_input_file
    return true
  end

  def build_default_timeframe
    build_timeframe
    return true
  end
end
