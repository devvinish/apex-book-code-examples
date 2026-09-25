-- @session app=200 page=1
-- @expect-error
declare
    l_error  apex_error.t_error;
    l_result apex_error.t_error_result;

    -- an error handling function, as the application's Error Handling Function setting calls it
    function handle_error(p_error in apex_error.t_error) return apex_error.t_error_result is
        l_result apex_error.t_error_result := apex_error.init_error_result(p_error => p_error);
    begin
        if p_error.ora_sqlcode in (-1, -2091, -2290, -2291, -2292) then
            -- constraint violations: a message per constraint
            l_result.message := case apex_error.extract_constraint_name(p_error => p_error)
                                    when 'ORB_PROMOTIONS_DATES_CK' then 'A promotion must end after it starts.'
                                    else apex_error.get_first_ora_error_text(p_error => p_error) end;
            l_result.additional_info := null;
        end if;
        apex_error.auto_set_associated_item(p_error_result => l_result, p_error => p_error);
        return l_result;
    end;
begin
    begin
        insert into orb_promotions (promotion_id, promotion_name, start_date, end_date, discount_pct)
        values (999, 'Test', date '2026-06-30', date '2026-06-01', 10);
    exception when others then
        l_error.message          := sqlerrm;
        l_error.ora_sqlcode      := sqlcode;
        l_error.ora_sqlerrm      := sqlerrm;
        l_error.display_location := apex_error.c_inline_in_notification;
    end;

    dbms_output.put_line('ORA text:   ' || apex_error.get_first_ora_error_text(p_error => l_error));
    dbms_output.put_line('with code:  ' || apex_error.get_first_ora_error_text(p_error => l_error, p_include_error_no => true));
    dbms_output.put_line('constraint: ' || apex_error.extract_constraint_name(p_error => l_error, p_include_schema => true));
    l_result := handle_error(l_error);
    dbms_output.put_line('shown:      ' || l_result.message || ' (' || l_result.display_location || ')');
end;
/
