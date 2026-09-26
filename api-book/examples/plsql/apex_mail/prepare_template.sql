-- @session app=200 page=1
declare
    l_subject varchar2(4000);
    l_html    clob;
    l_text    clob;
begin
    -- render the lab's e-mail template "approval-reminder" without sending it
    apex_mail.prepare_template(
        p_static_id    => 'approval-reminder',
        p_placeholders => json_object('ORDER_NUMBER'  value 'ORD-10042',
                                      'CUSTOMER_NAME' value 'Alpine Outfitters & Co.',
                                      'ORDER_TOTAL'   value '$1,047.30',
                                      'DISCOUNT_PCT'  value '5'),
        p_subject      => l_subject,
        p_html         => l_html,
        p_text         => l_text);
    dbms_output.put_line('subject: ' || l_subject);
    -- the HTML is the template's body inside the application's e-mail layout; show the body
    dbms_output.put_line(regexp_substr(l_html, '<p>Order.*Sales\.</p>', 1, 1, 'n'));
    dbms_output.put_line('text:');
    dbms_output.put_line(l_text);
end;
/
