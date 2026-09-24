-- Chapter 29: the status of background executions of Orbit Sales
select process_name, status, sofar, totalwork, created_on, last_updated_on
  from apex_appl_page_bg_proc_status
 where application_id = 100
 order by created_on desc
