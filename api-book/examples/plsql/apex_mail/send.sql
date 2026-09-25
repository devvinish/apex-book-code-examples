-- @session app=200 page=1
declare
    l_id number;
begin
    -- queue a message; the APEX mail job sends it (the lab has no mail server)
    l_id := apex_mail.send(
                p_to        => 'kim.lee@orbit.example',
                p_cc        => 'sales@orbit.example',
                p_from      => 'no-reply@orbit.example',
                p_subj      => 'Your order ORD-10042',
                p_body      => 'Thank you for your order. The invoice is attached.',
                p_body_html => '<p>Thank you for your order.</p><p><img src="cid:logo"></p>');
    apex_mail.add_attachment(p_mail_id => l_id, p_attachment => to_clob('sku,qty' || chr(10) || 'TNT-1002,2'),
                             p_filename => 'ORD-10042.csv', p_mime_type => 'text/csv');
    apex_mail.add_attachment(p_mail_id => l_id, p_attachment => apex_barcode.get_qrcode_png('ORD-10042'),
                             p_filename => 'logo.png', p_mime_type => 'image/png',
                             p_content_id => 'logo');                    -- shown inline by cid:logo

    for m in (select q.mail_to, q.mail_cc, q.mail_subj,
                     (select listagg(a.filename || ' (' || a.mime_type || ')', ', ')
                        from apex_mail_attachments a where a.mail_id = q.id) as files
                from apex_mail_queue q where q.id = l_id) loop
        dbms_output.put_line('to:      ' || m.mail_to || ', cc: ' || m.mail_cc);
        dbms_output.put_line('subject: ' || m.mail_subj);
        dbms_output.put_line('files:   ' || m.files);
    end loop;

    -- from a template: the subject and bodies come from "approval-reminder"
    l_id := apex_mail.send(
                p_template_static_id => 'approval-reminder',
                p_placeholders       => '{"ORDER_NUMBER":"ORD-10042","CUSTOMER_NAME":"Alpine Outfitters",'
                                     || '"ORDER_TOTAL":"$1,047.30","DISCOUNT_PCT":"5"}',
                p_to                 => 'approver@orbit.example');
    for m in (select mail_subj from apex_mail_queue where id = l_id) loop
        dbms_output.put_line('template: ' || m.mail_subj);
    end loop;

    rollback;   -- the messages leave the queue again: nothing is sent
end;
/
