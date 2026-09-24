declare
    l_html clob;
begin
    for c in (select c.customer_name, c.customer_type, c.loyalty_tier,
                     c.city, c.country_code, c.email, c.phone, c.credit_limit,
                     e.employee_name as sales_rep,
                     (select count(*)         from orb_orders o
                       where o.customer_id = c.customer_id
                         and o.status <> 'CANCELLED') as orders,
                     (select sum(order_total) from orb_orders o
                       where o.customer_id = c.customer_id
                         and o.status <> 'CANCELLED') as sales
                from orb_customers c
                left join orb_employees e on e.employee_id = c.sales_rep_id
               where c.customer_id = :P19_CUSTOMER_ID)
    loop
        l_html := '<div class="customer-summary">'
            || '<h3>' || apex_escape.html(c.customer_name) || '</h3>'
            || '<p>' || apex_escape.html(initcap(c.customer_type)) || ' customer in '
            || apex_escape.html(c.city) || ', ' || apex_escape.html(c.country_code)
            || ' &middot; ' || apex_escape.html(initcap(c.loyalty_tier)) || ' tier</p>'
            || '<ul>'
            || '<li><strong>' || c.orders || '</strong> orders, <strong>'
            || to_char(c.sales, 'FML999G999G990D00') || '</strong> in total</li>'
            || '<li>Credit limit ' || to_char(c.credit_limit, 'FML999G999G990') || '</li>'
            || '<li>Sales rep: ' || apex_escape.html(c.sales_rep) || '</li>'
            || '<li>' || apex_escape.html(c.email) || ' &middot; ' || apex_escape.html(c.phone) || '</li>'
            || '</ul></div>';
    end loop;
    return l_html;
end;
