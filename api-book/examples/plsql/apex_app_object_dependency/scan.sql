begin
    apex_util.set_workspace('APEXBOOK');
    -- which database objects does page 8 (Orders) use?
    apex_app_object_dependency.scan(p_application_id => 200, p_page_id => 8,
                                    p_options => apex_app_object_dependency.c_option_dependencies);
end;
/

select referenced_type, referenced_name, usage_count
  from apex_used_db_objects
 where application_id = 200 and referenced_owner = 'ORBIT'
 order by referenced_type, referenced_name;

begin
    apex_app_object_dependency.clear_cache(p_application_id => 200);
end;
/
