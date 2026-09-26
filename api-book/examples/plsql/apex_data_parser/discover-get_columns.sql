select c.column_position, c.column_name, c.data_type, c.format_mask
  from table(apex_data_parser.get_columns(
               apex_data_parser.discover(          
                   p_content   => apex_util.clob_to_blob(
                                    'SKU,Product,Price,Launched,In Stock' || chr(10) ||
                                    'TNT-2P,Trailblazer Tent,249.00,14.03.2025,Y' || chr(10) ||
                                    'BAG-0F,Nightfall Bag,389.50,01.10.2024,N'),
                   p_file_name => 'products.csv'))) c;
