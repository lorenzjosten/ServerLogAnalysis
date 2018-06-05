class Analysis < ApplicationRecord
  has_one :input_file, dependent: :destroy
  has_one :timeframe, dependent: :destroy
  validates_associated :input_file, :timeframe
end
