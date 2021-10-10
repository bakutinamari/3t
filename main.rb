require_relative "station"
require_relative "pessenger_train"
require_relative "cargo_train"
require_relative "route"
require_relative "pessenger_wagon"
reguire_relative "cargo_wagon"

class Main
  def initialize
    @stattions = []
    @trains = []
    @route = []
  end
  
  def create_station
    puts "Enter station's name"
    name = gets.chomp
  
    station = Stations.new(name)
    stations.push(station)
    
    print "Station: #{station.name}"
  end
  
  def create_train
    loop do 
      puts "Enter train type ('p' - passenger, 'c' - create)"
      train_type = gets.chomp
      break if train_type['p','c'].include?(train_type)
    end 
    
    print "Enter train number"
    train_number = gets.chomp
    
    train_number == 'p'? PassengerTrain.new(train_number) : CreateTrain.new(train_number)
    train = train_number
    trains.push(train)
    
    print "Train #{train.number} create"
  end
  
  def add_wagon_to_train
    print "Enter wagon type('p' - passenger, 'c' - create)"
    wagon_type = gets.chomp
    break if wagon_type['p','c'].include?(wagon_type)
  end
  
  print "Enter wagon type"
  wagon_type == 'p'? PassengerWagon.new(wagon_type) : CreateWagon.new(wagon_type)
  wagon = wagon_type
  
  print "Enter train number"
  train_number = gets.chomp
  train = self.get_train(train_number)
  return if !train
  train.add_wagon(wagon)
  
  puts "Add #{wagon.type} to train #{train.number}"
  end
  
  def del_wagin_from_train
    print "Enter train number"
    train_number = gets.chomp
    
    self.get_train(train_number).del_wagon
     
    print "Delete wagon from train #{train_number}"
  end
  
  def get_station(name)
    stations.select{|station|station.name == name}.first
  end
  
  def get_train(number)
    trains.select{|train|train.number == number}.first
  end 
  
  def get_route(first_station_name, last_station_name)
    routes.select{(|route|(route.stations.first.name == first_station_name&&route.stations.last.name == last_station_name)}.first
  end
  
  def create_route
    print "Enter first station name"
    first_station_name = gets.chomp
    
    print "Enter last station name"
    last_station_name = gets.chomp
    
    first_station = self.get_station(first_station_name)
    last_station = self.get_station(last_station_name)
    route = Route.new(first_station, last_station)
    routes.push(route)
    puts "Route #{first.stations.first.name} - #{last.stations.last.name} created"
  end
  
  def add_route_to_train
    print "Enter first station name"
    first_station_name = gets.chomp
    
    print "Enter last station name"
    last_station_name = gets.chomp
    
    print "Enter train number"
    train_number = gets.champ
    
    route = self.get_route(first_station_name, last_station_name)
    train = self.get_train(train_number)
    return if !route||!train
    
    train.add_route(route)
    self.get.station(first_station_name).add_train(train)
    
    puts "Route #{route.stations.first.name} - #{route.stations.last.name} add to train(train.number)"
  end
  
  def add_station_to_route
    print "Enter station name"
    station_name = gets.chomp
    
    print "Enter first station name"
    first_station_name = gets.chomp
    
    print "Enter last station name"
    last_station_name = gets.chomp
    
    route = self.get_route(first_station_name, last_station_name)
    station =self.get_station(station_name)
    return if !route||!station
    route.add_station(station)
    
    puts "Station #{station.name} added route #{stations.first} - #{stations.last}"
  end
  
  def del_station_from_route
    print "Enter station name"
    station_name = gets.chomp
    
    print "Enter first station name"
    first_station_name = gets.chomp
    
    print "Enter last station name"
    last_station_name = gets.chomp
    
    route = self.get_route(first_station_name, last_station_name)
    station =self.get_station(station_name)
    return if !route||!station
    route.del_station(station)
    
    puts "Station #{station.name} deleted from route #{stations.first} - #{stations.last}"
  end
  
  def move_train_forward
    print "Enter train number"
    train_number = gets.chomp
    train = self.get_train(train_number)
    return if!train||!train.route
    train.move_forward
    prev_station = train.get_prev_station
    prev_station.del_trains(train)
    current_station = train.get_current_station
    current_station.add_trains(train)
    
    puts "Train #{train.number} moved to #{current.station.name} from #{prev_station.name}"
  end
  
  def move_train_backward
    print "Enter train number"
    train_number = gets.chomp
    train = self.get_train(train_number)
    return if!train||!train.route
    train.move_backward
    next_station = train.get_prev_station
    next_station.del_trains(train)
    current_station = train.get_current_station
    current_station.add_trains(train)
    
    puts "Train #{train.number} moved to #{current.station.name} from #{next_station.name}"
  end
end
