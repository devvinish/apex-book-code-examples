select region,
       to_char(sales_month, 'YYYY "Q"Q') as quarter,
       sum(sales_amount)                 as sales
  from orb_sales_by_month_v
 where sales_month >= add_months(trunc(sysdate, 'Q'), -9)
 group by region, to_char(sales_month, 'YYYY "Q"Q')
