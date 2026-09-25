-- @session app=200 page=1 user=ADMIN
declare
    l_min_length boolean; l_new_differs boolean; l_one_alpha boolean; l_one_numeric boolean; l_one_punct boolean;
    l_one_upper boolean; l_one_lower boolean; l_not_like_username boolean; l_not_like_ws_name boolean;
    l_not_like_words boolean; l_not_reusable boolean;
    function tf(b boolean) return varchar2 is begin return case when b then 'T' else 'F' end; end;
begin
    apex_util.strong_password_check(
        p_username => 'ORBIT_DEMO', p_password => 'orbit', p_old_password => null, p_workspace_name => 'APEXBOOK',
        p_use_strong_rules => true,                    -- the built-in rules, not the instance's
        p_min_length_err => l_min_length, p_new_differs_by_err => l_new_differs, p_one_alpha_err => l_one_alpha,
        p_one_numeric_err => l_one_numeric, p_one_punctuation_err => l_one_punct, p_one_upper_err => l_one_upper,
        p_one_lower_err => l_one_lower, p_not_like_username_err => l_not_like_username,
        p_not_like_workspace_name_err => l_not_like_ws_name, p_not_like_words_err => l_not_like_words,
        p_not_reusable_err => l_not_reusable);
    dbms_output.put_line('"orbit" fails: min length ' || tf(l_min_length) || ', numeric ' || tf(l_one_numeric)
        || ', punctuation ' || tf(l_one_punct) || ', upper ' || tf(l_one_upper) || ', like user name ' || tf(l_not_like_username));
    dbms_output.put_line(regexp_replace(apex_util.strong_password_validation(
        p_username => 'ORBIT_DEMO', p_password => 'orbit', p_workspace_name => 'APEXBOOK'), '<[^>]+>', ' | '));
end;
/
