declare
    l_svg clob;
    l_png blob;
begin
    l_svg := apex_barcode.get_qrcode_svg(p_value => 'https://orbit.example/o/ORD-10042',
                                         p_size => 120, p_eclevel => 'M');      -- L, M, Q, or H
    dbms_output.put_line('QR SVG:       ' || dbms_lob.getlength(l_svg) || ' chars, ' || substr(l_svg, 1, 60) || '...');

    l_png := apex_barcode.get_qrcode_png(p_value => 'https://orbit.example/o/ORD-10042',
                                         p_scale => 4, p_quiet => 2,
                                         p_foreground_color => '#1F3A5F');
    dbms_output.put_line('QR PNG:       ' || dbms_lob.getlength(l_png) || ' bytes');

    l_png := apex_barcode.get_code128_png(p_value => 'TNT-1002', p_scale => 2);
    dbms_output.put_line('Code 128 PNG: ' || dbms_lob.getlength(l_png) || ' bytes');
    l_svg := apex_barcode.get_code128_svg(p_value => 'TNT-1002', p_size => 60);
    dbms_output.put_line('Code 128 SVG: ' || dbms_lob.getlength(l_svg) || ' chars');

    l_svg := apex_barcode.get_ean8_svg(p_value => '9638507');                -- 7 digits + check digit
    dbms_output.put_line('EAN-8 SVG:    ' || dbms_lob.getlength(l_svg) || ' chars');
    begin
        l_png := apex_barcode.get_ean8_png(p_value => 'TNT-1002');
    exception when others then
        dbms_output.put_line('EAN-8 of TNT-1002: ' || regexp_replace(sqlerrm, 'ORA-\d+: '));
    end;
end;
/
