require 'csv'
require 'activerecord-import'

csv_file_path = Rails.root.join('db', 'airbnb_nyc.csv')


neighbourhood_groups_set = Set.new
neighbourhoods_set = Set.new
room_types_set = Set.new
hosts_set = Set.new
CSV.foreach(csv_file_path, headers: true) do |row|
  neighbourhood_groups_set.add(row['neighbourhood_group'])
  neighbourhoods_set.add([row['neighbourhood'], row['neighbourhood_group']])
  room_types_set.add(row['room_type'])
  hosts_set.add([row['host_id'], row['host_name']])
end


NeighbourhoodGroup.import neighbourhood_groups_set.map { |name| NeighbourhoodGroup.new(name: name) }
RoomType.import room_types_set.map { |name| RoomType.new(name: name) }
Host.import hosts_set.map { |id, name| Host.new(host_id: id, host_name: name) }


neighbourhoods = []
ng_cache = NeighbourhoodGroup.all.index_by(&:name)
neighbourhoods_set.each do |n_name, ng_name|
  neighbourhoods << Neighbourhood.new(name: n_name, neighbourhood_group: ng_cache[ng_name])
end
Neighbourhood.import neighbourhoods


rooms = []
rt_cache = RoomType.all.index_by(&:name)
hosts_cache = Host.all.index_by(&:host_id)
neighbourhoods_cache = Neighbourhood.all.index_by(&:name)
CSV.foreach(csv_file_path, headers: true) do |row|
  rooms << Room.new(
    name: row['name'],
    latitude: row['latitude'],
    longitude: row['longitude'],
    price: row['price'],
    minimum_nights: row['minimum_nights'],
    number_of_reviews: row['number_of_reviews'],
    reviews_per_month: row['reviews_per_month'],
    calculated_host_listings_count: row['calculated_host_listings_count'],
    availability_365: row['availability_365'],
    host: hosts_cache[row['host_id'].to_i],
    neighbourhood: neighbourhoods_cache[row['neighbourhood']],
    room_type: rt_cache[row['room_type']]
  )
end
Room.import rooms

puts "Data seeding completed!"
