class Analysis < ApplicationRecord
  model_name.instance_variable_set(:@route_key, 'analysis')

  has_one :input_file, dependent: destroy
  has_one :timeframe, dependent: destroy
  has_many :access_data, through :input_file

  before_create :create_default_input_file, :create_default_timeframe

  private

  def create_default_input_file
    create_input_file
    return true
  end

  def create_default_timeframe
    create_timeframe
    return true
  end
end
