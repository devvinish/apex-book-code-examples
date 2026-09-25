-- @session app=200 page=1
begin
    -- for links and images in e-mails, which need absolute URLs
    -- (from the instance setting "Application Express Instance URL")
    dbms_output.put_line('instance: [' || apex_mail.get_instance_url || ']');
    dbms_output.put_line('images:   [' || apex_mail.get_images_url || ']');
end;
/
