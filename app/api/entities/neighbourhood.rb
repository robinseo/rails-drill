module Entities
  class Neighbourhood < Grape::Entity
    expose :id,
           :name
  end
end