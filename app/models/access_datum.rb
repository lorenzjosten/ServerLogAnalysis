class AccessDatum < ApplicationRecord
  belongs_to :input_file
  belongs_to :analysis
end
