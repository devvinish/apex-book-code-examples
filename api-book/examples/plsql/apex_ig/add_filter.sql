-- @session app=200 page=9
declare
    procedure show(p_label varchar2) is
        l_filters varchar2(4000);
    begin
        select listagg(f.type || ' ' || (select c.name from apex_appl_page_ig_columns c where c.column_id = f.column_id)
                       || ' ' || f.operator || ' ' || f.expression, '; ') within group (order by f.filter_id)
          into l_filters
          from apex_appl_page_ig_rpt_filters f
          join apex_appl_page_ig_rpts r on r.report_id = f.report_id
         where r.application_id = 200 and r.page_id = 9 and r.session_id = v('APP_SESSION');
        dbms_output.put_line(rpad(p_label, 9) || nvl(l_filters, '-'));
    end;
begin
    -- the Stores grid of page 9; in a page submit process, not while the page renders
    apex_ig.add_filter(p_page_id => 9, p_region_static_id => 'stores', p_report_static_id => 'primary',
                       p_column_name => 'STATE', p_operator_abbr => 'EQ', p_filter_value => 'CO');
    -- by region ID: without a report ID, the last viewed report
    apex_ig.add_filter(p_page_id => 9, p_region_id => apex_region.get_id(p_page_id => 9, p_dom_static_id => 'stores'),
                       p_filter_value => 'Denver', p_report_id => null);            -- no column: a row search
    show('filters');
    dbms_output.put_line('last viewed report: ' || apex_ig.get_last_viewed_report_id(
                             p_page_id => 9, p_region_id => apex_region.get_id(p_page_id => 9, p_dom_static_id => 'stores')));

    apex_ig.reset_report(p_page_id => 9, p_region_static_id => 'stores', p_report_static_id => 'primary');
    show('reset');
end;
/
