-- @session app=200 page=1
-- @setup begin apex_dg_data_gen.remove_blueprint('ORBIT_LEADS'); exception when others then null; end;
declare
    l_bp     number;
    l_output clob;
    l_ext    varchar2(20);
    l_mime   varchar2(200);
    l_errors clob;
begin
    -- a blueprint: a table LEADS with generated names, cities, dates, and weighted statuses
    apex_dg_data_gen.add_blueprint(p_name => 'ORBIT_LEADS', p_default_schema => 'ORBIT', p_blueprint_id => l_bp);
    apex_dg_data_gen.add_table(p_blueprint => 'ORBIT_LEADS', p_sequence => 1, p_table_name => 'LEADS',
                               p_rows => 4, p_table_id => l_bp);
    apex_dg_data_gen.add_column(p_blueprint => 'ORBIT_LEADS', p_sequence => 1, p_table_name => 'LEADS',
        p_column_name => 'LEAD_ID', p_data_source_type => 'SEQUENCE', p_column_id => l_bp);
    apex_dg_data_gen.add_column(p_blueprint => 'ORBIT_LEADS', p_sequence => 2, p_table_name => 'LEADS',
        p_column_name => 'NAME', p_data_source_type => 'BUILTIN', p_data_source => 'person.forward_name', p_column_id => l_bp);
    apex_dg_data_gen.add_column(p_blueprint => 'ORBIT_LEADS', p_sequence => 3, p_table_name => 'LEADS',
        p_column_name => 'CITY', p_data_source_type => 'BUILTIN', p_data_source => 'location.city', p_column_id => l_bp);
    apex_dg_data_gen.add_column(p_blueprint => 'ORBIT_LEADS', p_sequence => 4, p_table_name => 'LEADS',
        p_column_name => 'STATUS', p_data_source_type => 'INLINE', p_data_source => 'NEW,60;CONTACTED,30;WON,10',
        p_column_id => l_bp);
    apex_dg_data_gen.add_column(p_blueprint => 'ORBIT_LEADS', p_sequence => 5, p_table_name => 'LEADS',
        p_column_name => 'CREATED_ON', p_data_source_type => 'BUILTIN', p_data_source => 'date.date_between_min_and_max',
        p_min_date_value => date '2026-01-01', p_max_date_value => date '2026-06-30', p_format_mask => 'YYYY-MM-DD',
        p_column_id => l_bp);

    apex_dg_data_gen.generate_data(p_blueprint => 'ORBIT_LEADS', p_format => 'CSV',
                                   p_output => l_output, p_file_ext => l_ext, p_mime_type => l_mime, p_errors => l_errors);
    dbms_output.put_line('leads.' || l_ext || ' (' || l_mime || '):');
    dbms_output.put_line(l_output);

    dbms_output.put_line('examples of person.first_name: '
        || apex_string.join(apex_dg_data_gen.get_example(p_friendly_name => 'person.first_name', p_rows => 4), ', '));
    dbms_output.put_line('blueprint JSON: ' || dbms_lob.getlength(apex_dg_data_gen.export_blueprint(p_name => 'ORBIT_LEADS'))
                         || ' characters');
    apex_dg_data_gen.remove_blueprint(p_name => 'ORBIT_LEADS');
end;
/
