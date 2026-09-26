-- @session app=200 page=1
begin
    -- subscriptions come from the browser (the "Push Notifications" settings page of a PWA)
    dbms_output.put_line('ADMIN subscribed: ' || case when apex_pwa.has_push_subscription(
        p_application_id => 200, p_user_name => 'ADMIN') then 'yes' else 'no' end);

    -- queued, and sent by a job, to every device the user subscribed with
    apex_pwa.send_push_notification(
        p_application_id => 200,
        p_user_name      => 'ADMIN',
        p_title          => 'Order ORD-12259 needs approval',
        p_body           => 'Discount 15% on $2,480.00',
        p_target_url     => apex_page.get_url(p_page => 8));
    apex_pwa.push_queue;      -- send now instead of waiting for the job
    dbms_output.put_line('queued and pushed');
end;
/
