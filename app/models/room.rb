class Room < ApplicationRecord
  belongs_to :host
  belongs_to :neighbourhood
  belongs_to :room_type
end
