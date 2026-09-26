select apex_string.format(
           p_message    => 'Customer: %0',
           p0           => 'Wildflower Travel Company of the Pacific Northwest',
           p_max_length => 20) as message
  from dual;
