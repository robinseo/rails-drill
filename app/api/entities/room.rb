module Entities
  class Room < Grape::Entity
    format_with(:iso_timestamp) { |dt| dt.iso8601 }

    expose :id,
           :name,
           :price,
           :minimum_nights,
           :number_of_reviews
    expose :geo do
      expose :latitude,
             :longitude
    end
    expose :host, using: Entities::Host
    expose :neighbourhood, using: Entities::Neighbourhood
    expose :room_type, using: Entities::RoomType

    with_options(format_with: :iso_timestamp) do
      expose :created_at,
             :updated_at
    end

  end
end
