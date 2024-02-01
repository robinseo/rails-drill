class V1::Room < Grape::API
  resource :rooms do
    desc 'Create a new room'
    params do
      requires :name, type: String, desc: 'Room name'
      requires :latitude, type: Float, desc: 'Latitude'
      requires :longitude, type: Float, desc: 'Longitude'
      requires :price, type: Float, desc: 'Price per night'
      requires :minimum_nights, type: Integer, desc: 'Minimum nights'
      requires :availability_365, type: Integer, desc: 'Availability 365'
      requires :host_id, type: Integer, desc: 'Host Id'
      requires :neighbourhood_id, type: Integer, desc: 'Neighborhood Id'
      requires :room_type_id, type: Integer, desc: 'Room Type Id'
      optional :optional_params, type: String, desc: 'Optional Param'
    end
    post do
      puts declared(params)
    end

    desc 'Return a list of rooms'
    params do
      optional :page, type: Integer, default: 1, desc: 'Page number'
      optional :per, type: Integer, default: 25, desc: 'Per page number'
      optional :price_min, type: Integer, desc: 'Minimum price'
      optional :price_max, type: Integer, desc: 'Maximum price'
      optional :neighbourhood, type: String, desc: 'Neighbourhood name'
      optional :room_type, type: String, desc: 'Room type'
    end
    get do
      rooms = Room.includes(:host, :neighbourhood, :room_type)
                  .page(params[:page])
                  .per(params[:per])
                  .then { |rooms| params[:price_min] ? rooms.where('price >= ?', params[:price_min]) : rooms }
                  .then { |rooms| params[:price_max] ? rooms.where('price <= ?', params[:price_max]) : rooms }
                  .then { |rooms| params[:neighbourhood] ? rooms.where(neighbourhood: params[:neighbourhood]) : rooms }
                  .then { |rooms| params[:room_type] ? rooms.where(room_type: params[:room_type]) : rooms }

      present :rooms, rooms, with: Entities::Room
      present :pagination, paginate_info(rooms)
    end

    desc 'Return a room'
    params do
      requires :id, type: Integer, desc: 'room ID'
    end
    route_param :id do
      get do
        present Room.find(params[:id]), with: Entities::Room
      end
    end
  end
end