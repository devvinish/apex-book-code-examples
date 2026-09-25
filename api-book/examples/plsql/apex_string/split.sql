select column_value as tag
  from table(apex_string.split('tents,backpacks,,stoves', ','));
