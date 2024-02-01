class Neighbourhood < ApplicationRecord
  belongs_to :neighbourhood_group
  has_many :rooms
end
