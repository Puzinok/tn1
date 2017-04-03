class Navigation
  MENU = {
    1 => app.create_station,
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
end
