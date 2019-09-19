class Station
    
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    puts "Построена станция #{name}"
  end

  def get_train(train)
    trains << train
    puts "На станцию #{name} прибыл поезд №#{train.number}"
  end

  def send_train(train)
    trains.delete(train)
    train.station = nil
    puts "Со станции #{name} отправился поезд №#{train.number}"
  end


  def show_trains(type = nil)
      if type
        puts "Поезда на станции #{name} типа #{type}: "  
        trains.each{|train| puts train.number if train.type == type}
      else
        puts "Поезда на станции #{name}: "
        trains.each{|train| puts train.number}
      end
  end
end


class Route
  
  attr_accessor :sts, :from, :to
  
  def initialize (from, to)
    @sts = [from, to]
    puts "Создан маршрут #{from.name} - #{to.name}"
  end

  def add_st(st)
    sts.insert(-2, st) 
    puts "К маршруту #{sts.first.name} - #{sts.last.name} добавлена станция #{st.name}"
  end

  def remove_st(st)
    if [sts.first, sts.last].include?(st)
      puts "Первую и последнюю станции маршрута удалять нельзя!"
    else 
      sts.delete(st)
      puts "Из маршрута #{sts.first.name} - #{sts.last.name} удалена станция #{st.name}"
    end
  end

  def show_sts
    puts "В маршрут #{sts.first.name} - #{sts.last.name} входят станции: "
    sts.each{|st| puts " #{st.name}" }
  end  
end

class Train

  attr_accessor :speed, :number, :car_count, :route, :station
  attr_reader :type

  def initialize(number, type, car_count)
    @number = number
    @type = type
    @car_count = car_count
    @speed = 0
    puts "Создан поезд № #{number}. Тип: #{type}. Количество вагонов: #{car_count}."
  end

  def stop
    speed = 0
  end

  def add_car
    if speed.zero? 
      car_count += 1
      puts "К поезду №#{number} прицепили вагон. Теперь их #{car_count}."
    else 
      puts "На ходу вагоны не добавляются!"
    end
  end

  def remove_car
    if car_count.zero?
      puts "Вагонов уже не осталось."
    elsif speed.zero? 
      car_count -= 1
      puts "От поезда №#{number} отцепили вагон. Теперь их #{car_count}."
    else 
      puts "На ходу вагоны не отцепляются!"
    end
  end

  def take_route(route)
    route = route
    puts "Поезду №#{number} задан маршрут #{route.sts.first.name} - #{route.sts.last.name}" 
  end

  def go_to(st)
    if route.nil?
      puts "Без маршрута поезд не ходит."
    elsif @st == st
      puts "Поезд №#{@number} и так на станции #{@st.name}"
    elsif route.sts.include?(st)
      @st.send_train(self) if @st
      @st = st
      st.get_train(self)
    else
      puts "Станция #{st.name} не входит в маршрут поезда №#{number}"
    end
  end

  def sts_around
    if route.nil?
      puts "Маршрут не задан"
    else
      st_index = route.sts.index(st)
      puts "Сейчас поезд на станции #{st.name}."
      puts "Предыдущая станция - #{route.sts[st_index - 1].name}." if st_index != 0
      puts "Следующая - #{route.sts[st_index + 1].name}." if st_index != route.sts.size - 1
    end
  end
end


st_msc = Station.new("Москва")
st_ufa = Station.new("Уфа")
st_kzn = Station.new("Казань")
st_sam = Station.new("Самара")
st_spb = Station.new("Санкт-Петербург")
st_kzn = Station.new("Казань")
st_vld = Station.new("Владивосток")

route_msc_kzn = Route.new(st_msc, st_kzn)
route_msc_kzn.add_st(st_sam)
route_msc_kzn.add_st(st_spb)
route_msc_kzn.show_sts
route_msc_kzn.remove_st(st_msc)
route_msc_kzn.remove_st(st_kzn)
route_msc_kzn.remove_st(st_sam)
route_msc_kzn.show_sts

train1 = Train.new(1,"пассажирский", 22)
train2 = Train.new(2, "пассажирский", 20)
train3 = Train.new(3,"грузовой", 30)

train1.take_route(route_msc_kzn)
train1.go_to(st_kzn)
train1.go_to(st_spb)

st_kzn.show_trains
st_spb.show_trains

train1.go_to(st_spb)
train1.go_to(st_kzn)

st_spb.get_train(train2)
st_spb.get_train(train3)

st_spb.show_trains("грузовой")
st_vld.show_trains("пассажирский")
train2.sts_around
train1.sts_around
