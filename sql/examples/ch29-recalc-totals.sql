-- Chapter 29: Recalculate Order Totals (page 8, child of the Recalculate Totals execution chain)
declare
    l_total pls_integer;
    l_done  pls_integer := 0;
begin
    select count(*) into l_total from orb_orders;
    for o in (select order_id from orb_orders) loop
        orb_sales.recalc_order_total(p_order_id => o.order_id);
        l_done := l_done + 1;
        if mod(l_done, 100) = 0 or l_done = l_total then
            apex_background_process.set_progress(
                p_totalwork => l_total,
                p_sofar     => l_done);
        end if;
    end loop;
end;
