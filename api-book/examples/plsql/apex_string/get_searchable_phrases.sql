select column_value as phrase
  from table(apex_string.get_searchable_phrases(
                 p_strings   => apex_t_varchar2('Trailblazer 2-Person Tent', 'Ultralight tent for two hikers'),
                 p_max_words => 2));
