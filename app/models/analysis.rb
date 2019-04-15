class Analysis < ApplicationRecord
  has_one :input_file, dependent: :destroy
  validates_associated :input_file
end
