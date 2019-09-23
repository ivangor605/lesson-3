require './station.rb'
require './route.rb'
require './train.rb'

station_msc = Station.new('Москва')
station_ufa = Station.new('Уфа')
station_kzn = Station.new('Казань')
station_sam = Station.new('Самара')
station_spb = Station.new('Санкт-Петербург')
station_kzn = Station.new('Казань')
station_vld = Station.new('Владивосток')

train1 = Train.new(1, 'пассажирский', 22)
train2 = Train.new(2, 'пассажирский', 20)
train3 = Train.new(3, 'грузовой', 30)

station_msc.add_train(train1)
route_msc_kzn = Route.new(station_msc, station_kzn)
route_msc_kzn.add_station(station_sam)
route_msc_kzn.add_station(station_spb)
route_msc_kzn.show_stations
route_msc_kzn.delete_station(station_msc)
route_msc_kzn.delete_station(station_kzn)
route_msc_kzn.delete_station(station_sam)
route_msc_kzn.show_stations

train1 = Train.new(1, 'пассажирский', 22)
train2 = Train.new(2, 'пассажирский', 20)
train3 = Train.new(3, 'грузовой', 30)

train1.take_route(route_msc_kzn)
puts train1.next_station
train1.move_forward
puts train1.current_station

train1.move_backward

train1.move_backward
puts train1.current_station

