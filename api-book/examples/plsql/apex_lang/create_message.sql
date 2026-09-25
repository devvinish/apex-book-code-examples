-- @session app=200 page=1
declare
    l_id   number;
    l_text varchar2(4000);
begin
    apex_lang.create_message(p_application_id     => 200,
                             p_name               => 'ORBIT_WELCOME',
                             p_language           => 'en',
                             p_message_text       => 'Welcome back, %name! You have %count open orders.',
                             p_used_in_javascript => true,       -- also for apex.lang.getMessage
                             p_comment            => 'Home page greeting');
    apex_lang.create_message(p_application_id => 200, p_name => 'ORBIT_WELCOME', p_language => 'de',
                             p_message_text   => 'Willkommen zurück, %name! Sie haben %count offene Bestellungen.');
    dbms_output.put_line(apex_lang.get_message(p_name => 'ORBIT_WELCOME', p_params => apex_t_varchar2('name', 'Kim', 'count', '3')));
    dbms_output.put_line(apex_lang.get_message(p_name => 'ORBIT_WELCOME', p_params => apex_t_varchar2('name', 'Kim', 'count', '3'), p_lang => 'de'));

    select translation_entry_id into l_id from apex_application_translations
     where application_id = 200 and translatable_message = 'ORBIT_WELCOME' and language_code = 'en';
    apex_lang.update_message(p_id => l_id, p_message_text => 'Good to see you, %name.');
    select message_text into l_text from apex_application_translations where translation_entry_id = l_id;
    dbms_output.put_line('updated:     ' || l_text);
    -- get_message caches the messages it has read: the change shows in the next request
    dbms_output.put_line('get_message: ' || apex_lang.get_message(p_name => 'ORBIT_WELCOME',
                                                                  p_params => apex_t_varchar2('name', 'Kim', 'count', '3')));
    apex_lang.delete_message(p_id => l_id);
    rollback;   -- keep the lab as it was
end;
/
