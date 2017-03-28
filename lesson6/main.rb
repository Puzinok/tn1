require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'passenger_carriage'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'application'

app = Application.new


loop do

  puts "1 - Создать станцию"
  puts "2 - Создать поезд"
  puts "3 - Создать маршрут"
  puts "4 - Изменить маршрут"
  puts "5 - Назначить маршрут поезду"
  puts "6 - Прицепить вагон"
  puts "7 - Отцепить вагон"
  puts "8 - Переместить поезд вперед"
  puts "9 - Переместить поезд назад"
  puts "10 - Список станций"
  puts "11 - Cписок поездов на станции"

  puts "Выберите пункт меню:"
  answer = gets.to_i

  case answer
  when 1
    app.create_station
  when 2
    app.create_train
  when 3
    app.create_route
  when 4
    app.change_route
  when 5
    app.assign_route
  when 6
    app.hook_carriage
  when 7
    app.unhook_carriage
  when 8
    app.go_forward
  when 9
    app.go_backward
  when 10
    app.print_stations
  when 11
    app.trains_on_station
  else
    puts "Ошибочный ввод!"
  end
end