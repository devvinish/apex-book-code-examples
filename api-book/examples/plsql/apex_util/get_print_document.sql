-- @session app=200 page=1 user=ADMIN
-- @expect-error
declare
    l_pdf blob;
begin
    l_pdf := apex_util.get_print_document(
        p_report_data        => apex_util.clob_to_blob(
            '<ROWSET><ROW><ORDER_NUMBER>ORD-12283</ORDER_NUMBER></ROW></ROWSET>'),
        p_report_layout      => '<?xml version="1.0"?><xsl:stylesheet version="1.0"'
            || ' xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">'
            || '<xsl:template match="/"><fo:root><fo:layout-master-set><fo:simple-page-master master-name="A4">'
            || '<fo:region-body/></fo:simple-page-master></fo:layout-master-set><fo:page-sequence master-reference="A4">'
            || '<fo:flow flow-name="xsl-region-body"><fo:block><xsl:value-of select="//ORDER_NUMBER"/></fo:block>'
            || '</fo:flow></fo:page-sequence></fo:root></xsl:template></xsl:stylesheet>',
        p_report_layout_type => 'xsl-fo',
        p_document_format    => 'pdf');
    dbms_output.put_line('PDF: ' || dbms_lob.getlength(l_pdf) || ' bytes, starts with '
        || utl_raw.cast_to_varchar2(dbms_lob.substr(l_pdf, 5, 1)));
exception
    when others then dbms_output.put_line(substr(sqlerrm, 1, 90));
end;
/
