-- Chapter 41: validation "Large discounts need approval" (page 10), with a translatable message
begin
    if to_number(:P10_DISCOUNT_PCT) > orb_sales.c_approval_discount_pct
       and :P10_STATUS = 'NEW'
    then
        return apex_lang.message(
                   p_name => 'ORBIT_DISCOUNT_APPROVAL',
                   p0     => orb_sales.c_approval_discount_pct);
    end if;
    return null;
end;
