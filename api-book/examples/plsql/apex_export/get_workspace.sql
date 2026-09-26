declare
    l_ws    number;
    l_files apex_t_export_files;
begin
    apex_util.set_workspace('APEXBOOK');
    l_ws := apex_util.find_security_group_id('APEXBOOK');

    l_files := apex_export.get_workspace(p_workspace_id => l_ws);          -- users, groups, remote servers, ...
    dbms_output.put_line('workspace: ' || l_files(1).name || ', ' || dbms_lob.getlength(l_files(1).contents) || ' chars');
    l_files := apex_export.get_workspace_files(p_workspace_id => l_ws);    -- the static workspace files
    dbms_output.put_line('files:     ' || l_files(1).name);
    l_files := apex_export.get_feedback(p_workspace_id => l_ws);           -- the feedback users left
    dbms_output.put_line('feedback:  ' || l_files(1).name);
end;
/
