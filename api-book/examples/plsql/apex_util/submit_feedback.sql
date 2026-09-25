-- @session app=200 page=2 user=ADMIN
declare
    l_feedback_id number;
begin
    dbms_output.put_line('feedback enabled: ' || case when apex_util.feedback_enabled then 'yes' else 'no' end);
    apex_util.submit_feedback(
        p_comment         => 'The Customers report should show the loyalty tier.',
        p_type            => 1,                          -- 1 general, 2 enhancement request, 3 bug
        p_application_id  => 200,
        p_page_id         => 2,
        p_email           => 'olivia.demo@orbit-outfitters.example',
        p_rating          => 4);
    select max(feedback_id) into l_feedback_id from apex_team_feedback where application_id = 200;
    apex_util.reply_to_feedback(p_feedback_id => l_feedback_id, p_status => 3,       -- 3: closed
        p_developer_comment => 'Planned for 1.1', p_public_response => 'Added in the next release.');
    apex_util.submit_feedback_followup(p_feedback_id => l_feedback_id, p_follow_up => 'Thank you!');
    dbms_output.put_line('follow up: ' || apex_util.get_feedback_follow_up(p_feedback_id => l_feedback_id, p_row => 1));
    for f in (select feedback, feedback_type, feedback_rating from apex_team_feedback where feedback_id = l_feedback_id) loop
        dbms_output.put_line('stored: "' || f.feedback || '", type ' || f.feedback_type || ', rating ' || f.feedback_rating);
    end loop;
    apex_util.delete_feedback_attachment(p_feedback_id => l_feedback_id);
    apex_util.delete_feedback(p_feedback_id => l_feedback_id);
    dbms_output.put_line('deleted');
end;
/
