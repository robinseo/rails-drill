module Entities
  class Host < Grape::Entity
    expose :id,
           :host_name
  end
end