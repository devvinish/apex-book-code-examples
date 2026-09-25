-- @session app=200 page=1
declare
    l_answer clob;
begin
    dbms_output.put_line('AI enabled: ' || case when apex_ai.is_enabled then 'yes' else 'no' end);

    -- one prompt, one answer, from the workspace's AI service "local-ollama" (llama3.2:3b)
    l_answer := apex_ai.generate(
                    p_prompt            => 'Write a one-sentence product teaser for the Trailblazer 2-Person Tent.',
                    p_system_prompt     => 'You write short, friendly copy for an outdoor equipment shop.',
                    p_service_static_id => 'local-ollama',
                    p_temperature       => 0);
    dbms_output.put_line(l_answer);

    -- an answer in a given JSON shape (OpenAI, OCI, and Cohere services; see the text for Ollama)
    begin
        l_answer := apex_ai.generate(
                        p_prompt               => 'Classify this review: "The zipper broke, but support replaced the tent."',
                        p_service_static_id    => 'local-ollama',
                        p_response_json_schema => '{"type":"object","properties":{"sentiment":{"type":"string"}}}');
        dbms_output.put_line(l_answer);
    exception when others then
        dbms_output.put_line(regexp_substr(regexp_replace(sqlerrm, 'ORA-\d+: '), 'failed with HTTP-\d+'));
    end;
end;
/
