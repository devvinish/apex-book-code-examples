-- Chapter 38: shared list of values SALES_REPS
select employee_id,
       employee_name,
       job_title,
       region,
       email
  from orb_employees
 where job_title in ('Sales Representative', 'Regional Sales Manager', 'Sales Director')
