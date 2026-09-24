declare
    l_answer clob;
begin
    l_answer := apex_ai.generate(
                    p_agent_static_id => 'orbit-assistant',
                    p_prompt          => 'What is the status of order ORD-12283, and who is the customer?');
    dbms_output.put_line(l_answer);
end;
