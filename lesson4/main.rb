require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'

stations = []

stations_name = %w(Аникеевка Бологое Поповка 141км)
stations_name.each{|n| stations << Station.new(n)}

def get_stations
  each_with_index {|st, i| puts "#{i} - #{st.name}"}
end
#public :get_stations

stations.get_stations