-- @session app=200 page=8
declare
    l_report apex_ir.t_report;
    procedure show(p_label varchar2) is
        l_conds varchar2(4000);
    begin
        -- the session's copy of the report ("working report") holds the user's changes
        select listagg(c.condition_type || ' ' || c.condition_column_name || ' ' || c.condition_operator
                       || ' ' || c.condition_expression, '; ') within group (order by c.condition_type, c.condition_column_name)
          into l_conds
          from apex_application_page_ir_cond c
          join apex_application_page_ir_rpt r on r.report_id = c.report_id
         where r.application_id = 200 and r.page_id = 8 and r.session_id = v('APP_SESSION');
        dbms_output.put_line(rpad(p_label, 9) || nvl(l_conds, '-'));
    end;
begin
    -- as a page process before the Orders report (page 8) renders
    apex_ir.add_filter(p_page_id => 8, p_region_static_id => 'orders',
                       p_report_column => 'STATUS', p_filter_value => 'Shipped', p_operator_abbr => 'EQ');
    apex_ir.add_filter(p_page_id => 8, p_region_static_id => 'orders',
                       p_report_column => 'CHANNEL', p_filter_value => 'Online,Phone', p_operator_abbr => 'IN');
    show('filters');
    dbms_output.put_line('last viewed report: ' || apex_ir.get_last_viewed_report_id(
                             p_page_id => 8, p_region_id => apex_region.get_id(p_page_id => 8, p_dom_static_id => 'orders')));

    -- the query the report runs now (GET_REPORT is deprecated)
    l_report := apex_ir.get_report(p_page_id => 8, p_region_id => apex_region.get_id(p_page_id => 8, p_dom_static_id => 'orders'));
    dbms_output.put_line(regexp_substr(l_report.sql_query, 'where .*', 1, 1, 'n'));
    for i in 1 .. l_report.binds.count loop
        dbms_output.put_line('  :' || l_report.binds(i).name || ' = ' || l_report.binds(i).value);
    end loop;

    apex_ir.reset_report(p_page_id => 8, p_region_static_id => 'orders');   -- back to the saved report
    show('reset');
    apex_ir.clear_report(p_page_id => 8, p_region_static_id => 'orders');   -- no filters, highlights, breaks
    show('cleared');
end;
/
