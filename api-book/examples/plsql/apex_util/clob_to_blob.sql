declare
    l_blob blob;
    l_clob clob;
begin
    l_blob := apex_util.clob_to_blob(p_clob => 'Orbit Outfitters: Grüße aus München', p_charset => 'AL32UTF8');
    dbms_output.put_line('BLOB: ' || dbms_lob.getlength(l_blob) || ' bytes, ' || rawtohex(dbms_lob.substr(l_blob, 6, 1)) || '...');
    l_clob := apex_util.blob_to_clob(p_blob => l_blob, p_charset => 'AL32UTF8');
    dbms_output.put_line('CLOB: ' || l_clob || ' (' || length(l_clob) || ' characters)');
end;
/
