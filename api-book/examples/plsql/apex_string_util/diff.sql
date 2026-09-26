select column_value as line
  from table(apex_string_util.diff(
                 p_left  => apex_t_varchar2('Tents', 'Stoves', 'Lanterns', 'Tarps'),
                 p_right => apex_t_varchar2('Tents', 'Stoves', 'Headlamps', 'Tarps'),
                 p_context => 1));
