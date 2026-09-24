-- Action "Approve Order": On Event = Complete, Outcome = Approved
begin
    orb_sales.approve_order(p_order_id => :APEX$TASK_PK);
end;

-- Action "Return Order": On Event = Complete, Outcome = Rejected
begin
    update orb_orders
       set status = 'NEW',
           notes  = substr(notes || case when notes is not null then chr(10) end
                           || 'Discount rejected by ' || :APP_USER, 1, 4000)
     where order_id = :APEX$TASK_PK
       and status   = 'PENDING_APPROVAL';
end;
