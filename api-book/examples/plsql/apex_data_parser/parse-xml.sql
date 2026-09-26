select p.line_number, p.col001, p.col002
  from table(apex_data_parser.parse(
               p_content      => apex_util.clob_to_blob(
                                   '<stores><store><code>DEN</code><city>Denver</city></store>'
                                || '<store><code>SEA</code><city>Seattle</city></store></stores>'),
               p_file_name    => 'stores.xml',
               p_row_selector => '/stores/store')) p;
