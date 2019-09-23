class Train
  attr_reader :type, :car_count, :speed

  def initialize(number, type, car_count)
    @number = number
    @type = type
    @car_count = car_count
    @speed = 0
    @route = nil
  end

  def increase_speed(value)
    @speed += value
  end

  def stop
    @speed = 0
  end

  def add_car
    @car_count += 1 unless moving?
  end

  def remove_car
    @car_count -= 1 if !moving? && @car_count > 0
  end

  def take_route(route)
    @route = route

    @current_station_index = 0
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    @route.stations[@current_station_index - 1]
  end

  def move_forward
    @current_station_index += 1 unless next_station.nil?
  end

  def move_backward
    @current_station_index += 1 unless previous_station.nil?
  end

  private

  def moving?
    @speed == 0
  end
end
