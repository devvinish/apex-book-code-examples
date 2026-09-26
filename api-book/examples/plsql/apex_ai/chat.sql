-- @session app=200 page=1
declare
    l_messages apex_ai.t_chat_messages := apex_ai.c_chat_messages;
    l_answer   clob;
begin
    -- the lab's AI agent "orbit-assistant": a system prompt and the tool order_lookup
    l_answer := apex_ai.chat(p_agent_static_id => 'orbit-assistant',
                             p_prompt          => 'What is the status of order ORD-12259?',
                             p_messages        => l_messages);
    dbms_output.put_line('1: ' || l_answer);

    -- l_messages holds the conversation, so the follow-up question has its context
    l_answer := apex_ai.chat(p_agent_static_id => 'orbit-assistant',
                             p_prompt          => 'Why does it need approval?',
                             p_messages        => l_messages);
    dbms_output.put_line('2: ' || l_answer);

    dbms_output.put_line('conversation:');
    for i in 1 .. l_messages.count loop
        dbms_output.put_line('  ' || rpad(l_messages(i).chat_role, 10)
            || case when l_messages(i).tool_calls is not null and l_messages(i).tool_calls.count > 0 then '(calls ' || l_messages(i).tool_calls(1).name || ')'
                    else substr(replace(l_messages(i).message, chr(10), ' '), 1, 70) end);
    end loop;
end;
/
