-- @session app=200 page=1 user=ADMIN
begin
    dbms_output.put_line(substr(regexp_replace(apex_util.prepare_url(
        'f?p=200:customers:' || v('APP_SESSION') || '::NO:RP:P2_SEARCH:tent'), '\d{12,}', '<session>'), 1, 90) || '...');
    dbms_output.put_line(substr(regexp_replace(apex_util.prepare_url(
        'f?p=200:3:' || v('APP_SESSION') || '::NO:3:P3_CUSTOMER_ID:42'), '\d{12,}', '<session>'), 1, 90) || '...');
end;
/
