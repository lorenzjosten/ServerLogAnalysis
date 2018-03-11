class Timeframe < ApplicationRecord
  model_name.instance_variable_set(:@route_key, 'timeframe')

  belongs_to :analysis
end
