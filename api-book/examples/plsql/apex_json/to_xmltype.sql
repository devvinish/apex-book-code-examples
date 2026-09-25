declare
    l_xml xmltype;
begin
    l_xml := apex_json.to_xmltype('{"sku":"TNT-2P","sizes":[2,3]}');
    dbms_output.put_line(l_xml.getclobval());
end;
/
