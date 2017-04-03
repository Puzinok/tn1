require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'application'

app = Application.new

MENU = {
  1 => :create_station,
  2 => :create_train,
  3 => :create_route,
  4 => :change_route,
  5 => :assign_route,
  6 => :hook_carriage,
  7 => :unhook_carriage,
  8 => :go_forward,
  9 => :go_backward,
  10 => :print_station,
  11 => :trains_on_station,
  12 => :cars_of_train,
  13 => :load_carriage
}.freeze

loop do
  puts '1 - Создать станцию'
  puts '2 - Создать поезд'
  puts '3 - Создать маршрут'
  puts '4 - Изменить маршрут'
  puts '5 - Назначить маршрут поезду'
  puts '6 - Прицепить вагон'
  puts '7 - Отцепить вагон'
  puts '8 - Переместить поезд вперед'
  puts '9 - Переместить поезд назад'
  puts '10 - Список станций и поездов'
  puts '11 - Cписок поездов на станции'
  puts '12 - Cписок вагонов у поезда'
  puts '13 - Занять место или объем в вагоне'

  puts 'Выберите пункт меню:'
  app.navigation(gets.to_i, MENU)
end
