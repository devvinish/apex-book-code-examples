-- @setup begin execute immediate 'drop table lab_leads purge'; exception when others then null; end;
-- @setup create table lab_leads (lead_id number primary key, name varchar2(100), city varchar2(60), score number(3), created_on date)
begin
    apex_util.set_workspace('APEXBOOK');

    -- create the UI defaults of a table from its columns, then adjust them:
    -- forms and reports created on the table later use these labels, masks, and help texts
    apex_ui_default_update.synch_table(p_table_name => 'LAB_LEADS');
    apex_ui_default_update.upd_form_region_title(p_table_name => 'LAB_LEADS', p_form_region_title => 'Lead');
    apex_ui_default_update.upd_report_region_title(p_table_name => 'LAB_LEADS', p_report_region_title => 'Leads');
    apex_ui_default_update.upd_label(p_table_name => 'LAB_LEADS', p_column_name => 'CREATED_ON', p_label => 'Created');
    apex_ui_default_update.upd_item_format_mask(p_table_name => 'LAB_LEADS', p_column_name => 'CREATED_ON',
                                                p_format_mask => 'DD-MON-YYYY');
    apex_ui_default_update.upd_report_alignment(p_table_name => 'LAB_LEADS', p_column_name => 'SCORE',
                                                p_report_alignment => 'R');
    apex_ui_default_update.upd_item_help(p_table_name => 'LAB_LEADS', p_column_name => 'SCORE',
                                         p_help_text => 'How likely the lead is to buy, from 0 to 100.');
    apex_ui_default_update.upd_display_in_report(p_table_name => 'LAB_LEADS', p_column_name => 'LEAD_ID',
                                                 p_display_in_report => 'N');

    for c in (select column_name, label, display_in_report, mask_form, alignment, help_text
                from apex_ui_defaults_columns where table_name = 'LAB_LEADS' order by display_seq_form) loop
        dbms_output.put_line(rpad(c.column_name, 11) || rpad(c.label, 9) || 'report ' || c.display_in_report
            || nvl2(c.mask_form, ', mask ' || c.mask_form, '') || nvl2(c.alignment, ', align ' || c.alignment, '')
            || nvl2(c.help_text, ', help', ''));
    end loop;

    apex_ui_default_update.del_table(p_table_name => 'LAB_LEADS');     -- remove them again
end;
/
