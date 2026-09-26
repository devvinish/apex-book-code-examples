declare
    l_mail varchar2(4000) := 'From: Linda Kim <linda.kim@example.com>' || chr(10)
        || 'Subject: Order ORD-12280 cancelled' || chr(10)
        || 'Please refund to billing@example.com. See https://orbit-outfitters.example/orders/12280 #refund #urgent 2026';
begin
    dbms_output.put_line('emails:      ' || apex_string.join(apex_string_util.find_email_addresses(l_mail), ', '));
    dbms_output.put_line('from:        ' || apex_string_util.find_email_from(l_mail));
    dbms_output.put_line('subject:     ' || apex_string_util.find_email_subject(l_mail));
    dbms_output.put_line('links:       ' || apex_string.join(apex_string_util.find_links(l_mail), ', '));
    dbms_output.put_line('tags:        ' || apex_string.join(apex_string_util.find_tags(l_mail), ', '));
    dbms_output.put_line('identifiers: ' || apex_string.join(apex_string_util.find_identifiers(l_mail, 'ORD'), ', '));
    dbms_output.put_line('phrases:     ' || apex_string.join(apex_string_util.find_phrases(apex_t_varchar2('refund', 'exchange'), l_mail), ', '));
    dbms_output.put_line('exists:      ' || case when apex_string_util.phrase_exists('order ord-12280', l_mail) then 'yes' else 'no' end);
end;
/
