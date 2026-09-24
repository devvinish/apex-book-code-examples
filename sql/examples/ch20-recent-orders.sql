select order_id,
       order_number,
       customer_name,
       upper(substr(customer_name, 1, 1)) ||
       upper(substr(customer_name, instr(customer_name, ' ') + 1, 1)) as initials,
       sales_rep,
       order_date,
       to_char(order_total, 'FML999G999G990D00') as total,
       status_label,
       case status
         when 'PENDING_APPROVAL' then 'warning'
         when 'CANCELLED'        then 'danger'
         when 'DELIVERED'        then 'success'
         else                         'info'
       end as status_state
  from orb_orders_v
