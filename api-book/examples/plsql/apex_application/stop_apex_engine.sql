-- @session app=200 page=1 user=ADMIN
-- @expect-error
begin
    begin
        -- in a process: owa_util.redirect_url('https://vinish.dev');
        apex_application.stop_apex_engine;
        dbms_output.put_line('not reached');
    exception
        when apex_application.e_stop_apex_engine then
            dbms_output.put_line('e_stop_apex_engine raised: ' || sqlerrm);
            -- in real code: raise;  (let APEX stop the request)
    end;
end;
/
