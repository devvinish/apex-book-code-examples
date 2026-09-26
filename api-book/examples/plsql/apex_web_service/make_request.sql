-- @session app=200 page=1
declare
    l_envelope clob := '<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body>'
                    || '<Add xmlns="http://tempuri.org/"><intA>40</intA><intB>2</intB></Add>'
                    || '</soap:Body></soap:Envelope>';
    l_xml      xmltype;
begin
    -- a public SOAP 1.1 calculator service
    l_xml := apex_web_service.make_request(
                 p_url      => 'http://www.dneonline.com/calculator.asmx',
                 p_action   => 'http://tempuri.org/Add',
                 p_envelope => l_envelope);
    dbms_output.put_line('Add: ' || apex_web_service.parse_xml(
                                        p_xml   => l_xml,
                                        p_xpath => '//AddResult/text()',
                                        p_ns    => 'xmlns="http://tempuri.org/"'));
    dbms_output.put_line('Body: ' || apex_web_service.parse_xml_clob(l_xml, '//soap:Body/*',
                                        'xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"'));

    -- the procedure stores the response in a collection instead
    apex_web_service.make_request(
        p_url             => 'http://www.dneonline.com/calculator.asmx',
        p_action          => 'http://tempuri.org/Multiply',
        p_collection_name => 'SOAP_RESPONSE',
        p_envelope        => replace(replace(l_envelope, '<Add ', '<Multiply '), '</Add>', '</Multiply>'));
    dbms_output.put_line('Multiply: ' || apex_web_service.parse_response(
                                             p_collection_name => 'SOAP_RESPONSE',
                                             p_xpath           => '//MultiplyResult/text()',
                                             p_ns              => 'xmlns="http://tempuri.org/"'));
end;
/
