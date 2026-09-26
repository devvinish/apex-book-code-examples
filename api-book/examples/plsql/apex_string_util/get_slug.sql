begin
    dbms_output.put_line('slug:        ' || apex_string_util.get_slug('Trailblazer 2-Person Tent (Olive)!'));
    dbms_output.put_line('with hash:   ' || apex_string_util.get_slug('Trailblazer 2-Person Tent', p_hash_length => 6));
    dbms_output.put_line('domain:      ' || apex_string_util.get_domain('https://shop.orbit-outfitters.example/tents?id=7'));
    dbms_output.put_line('extension:   ' || apex_string_util.get_file_extension('price-list.2026.XLSX'));
    dbms_output.put_line('file sizes:  ' || apex_string_util.to_display_filesize(950) || ', '
        || apex_string_util.to_display_filesize(1536000) || ', ' || apex_string_util.to_display_filesize(3221225472));
    dbms_output.put_line('whitespace:  ' || apex_string_util.replace_whitespace('Order  ORD-12283' || chr(9) || 'shipped'));
end;
/
