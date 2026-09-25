-- @session app=200 page=20
begin
    dbms_output.put_line('errors: ' || case when apex_error.have_errors_occurred then 'yes' else 'no' end);

    -- in a validation or process: the message goes to the notification area ...
    apex_error.add_error(p_message          => 'The order has no lines.',
                         p_display_location => apex_error.c_inline_in_notification);
    -- ... or next to a page item (and into the notification)
    apex_error.add_error(p_message          => 'Enter a quantity between 1 and 99.',
                         p_display_location => apex_error.c_inline_with_field_and_notif,
                         p_page_item_name   => 'P20_NUMBER');
    -- ... from a text message of the application, with placeholders
    apex_error.add_error(p_error_code       => 'APEX.PAGE_ITEM_IS_REQUIRED',
                         p0                 => 'Product',
                         p_display_location => apex_error.c_inline_with_field_and_notif,
                         p_page_item_name   => 'P20_PRODUCT');

    dbms_output.put_line('errors: ' || case when apex_error.have_errors_occurred then 'yes' else 'no' end);
end;
/
