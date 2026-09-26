-- @session app=200 page=2 user=ADMIN
declare
    l_region_id number;
    l_view_id   number;
begin
    l_region_id := apex_region.get_id(p_page_id => 2, p_dom_static_id => 'customers');
    select region_id into l_view_id
      from apex_application_page_regions
     where application_id = 200 and page_id = 2 and static_id = 'customers';
    dbms_output.put_line('get_id returns the region ID: ' || case when l_region_id = l_view_id then 'yes' end);
end;
/
