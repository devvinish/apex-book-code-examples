-- the .csv extension picks the CSV parser; p_skip_rows => 1 skips the header line
with f as (
    select apex_util.clob_to_blob(
             'SKU;Product;Price;Launched'            || chr(10) ||
             'TNT-2P;Trailblazer 2-Person Tent;249,00;14.03.2025' || chr(10) ||
             'BAG-0F;"Nightfall 0° Down Bag";389,50;01.10.2024'   || chr(10) ||
             'LMP-HD;Headlamp "Beam 400";39,95;')    as content
      from dual )
select p.line_number, p.col001, p.col002, p.col003, p.col004
  from f,
       table(apex_data_parser.parse(
                 p_content        => f.content,
                 p_file_name      => 'prices.csv',
                 p_decimal_char   => ',',
                 p_skip_rows      => 1)) p;
