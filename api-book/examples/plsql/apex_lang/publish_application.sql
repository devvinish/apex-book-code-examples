-- @setup begin apex_util.set_workspace('APEXBOOK'); begin apex_lang.delete_language_mapping(p_application_id => 200, p_language => 'fr'); exception when others then null; end; for m in (select translation_entry_id from apex_application_translations where application_id = 200 and language_code = 'fr') loop apex_lang.delete_message(m.translation_entry_id); end loop; end;
declare
    l_xliff clob;
    l_id    number;
    procedure show(p_label varchar2) is
    begin
        for m in (select translated_application_id, requires_synchronization from apex_application_trans_map
                   where primary_application_id = 200) loop
            dbms_output.put_line(rpad(p_label, 12) || 'fr -> ' || m.translated_application_id
                                 || ', needs publishing: ' || m.requires_synchronization);
        end loop;
    end;
begin
    apex_util.set_workspace('APEXBOOK');

    -- 1. a French version of the lab, published as application 200001
    apex_lang.create_language_mapping(p_application_id => 200, p_language => 'fr',
                                      p_translation_application_id => 200001);
    show('mapped');

    -- 2. copy the translatable strings into the translation repository
    apex_lang.seed_translations(p_application_id => 200, p_language => 'fr');

    -- 3. translate: one string directly ...
    select id into l_id from apex_application_trans_repos
     where application_id = 200 and language_code = 'fr' and application_page_id = 1 and dbms_lob.compare(from_string, to_clob('Home')) = 0
     fetch first 1 row only;
    apex_lang.update_translated_string(p_id => l_id, p_language => 'fr', p_string => 'Accueil');
    -- ... or a whole page as XLIFF, the format translation tools use
    l_xliff := apex_lang.get_xliff_document(p_application_id => 200, p_page_id => 1, p_language => 'fr');
    dbms_output.put_line(regexp_substr(l_xliff, '<trans-unit[^>]*>\s*<source>Home</source>\s*<target>[^<]*</target>'));
    apex_lang.apply_xliff_document(p_application_id => 200, p_language => 'fr',
        p_document => replace(l_xliff, '<target>Orders</target>', '<target>Commandes</target>'));

    -- 4. generate the translated application
    apex_lang.publish_application(p_application_id => 200, p_language => 'fr');
    show('published');

    apex_lang.update_language_mapping(p_application_id => 200, p_language => 'fr',
                                      p_new_trans_application_id => 200002);
    show('remapped');

    apex_lang.delete_language_mapping(p_application_id => 200, p_language => 'fr');   -- and the repository
    show('deleted');

    -- seed_translations also copied the text messages to French; they stay
    for m in (select translation_entry_id from apex_application_translations
               where application_id = 200 and language_code = 'fr') loop
        apex_lang.delete_message(p_id => m.translation_entry_id);
    end loop;
    dbms_output.put_line('French text messages deleted');
end;
/
