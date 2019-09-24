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
    @car_count += 1 if stopped?
  end

  def remove_car
    @car_count -= 1 if !stopped? && @car_count > 0
  end

  def take_route(route)
    @route = route

    @current_station_index = 0
    @current_station.add_train(self)
  end

  def current_station
    @route.stations[@current_station_index]
  end

  def next_station
    @route.stations[@current_station_index + 1]
  end

  def previous_station
    return unless @current_station_index > 0
    @route.stations[@current_station_index - 1]
  end

  def move_forward
    return if next_station.nil
    @current_station.send_train
    @next_station.add_train
    @current_station_index += 1
  end

  def move_backward
    return if previous_station.nil
    @current_station.send_train
    @previous_station.add_train
    @current_station_index -= 1
  end

  private

  def stopped?
    @speed == 0
  end
end
