-- p_row_selector names the array that holds the rows
with f as (
    select apex_util.clob_to_blob('{"order":"ORD-10042","items":['
                               || '{"sku":"TNT-2P","qty":2,"price":249},'
                               || '{"sku":"BAG-0F","qty":1,"price":389.5}]}') as content
      from dual )
select p.line_number, p.col001, p.col002, p.col003
  from f,
       table(apex_data_parser.parse(p_content      => f.content,
                                    p_file_name    => 'order.json',
                                    p_row_selector => 'items')) p;

-- which member landed in which column
select column_position, column_name, data_type
  from table(apex_data_parser.get_columns(apex_data_parser.get_file_profile));
