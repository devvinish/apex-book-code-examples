-- @session app=200 page=1 user=ADMIN
declare
    procedure show(p_label varchar2, p_url varchar2) is
    begin
        dbms_output.put_line(rpad(p_label, 10) || regexp_replace(substr(p_url, 1, 80), '\d{10,}', '<session>')
                             || case when length(p_url) > 80 then '...' end);
    end;
begin
    show('page:', apex_page.get_url(p_page => 'customers'));
    show('request:', apex_page.get_url(p_page => 'products', p_request => 'EXPORT', p_plain_url => true));
    show('absolute:', apex_page.get_url(p_page => 'home', p_absolute_url => true, p_session => 0));
    show('dialog:', apex_page.get_url(p_page => 3, p_clear_cache => '3',
                                      p_items => 'P3_CUSTOMER_ID', p_values => '42'));
end;
/
