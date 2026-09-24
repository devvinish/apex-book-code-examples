-- Loads the product images in sql/orbit/data/product-images/ into ORB_PRODUCTS.
-- Optional: the application works without images.
--
-- 1. Copy the images to a folder on the database server, for example with Docker:
--      docker exec <container> mkdir -p /opt/oracle/orbit-images
--      docker cp sql/orbit/data/product-images/. <container>:/opt/oracle/orbit-images/
-- 2. As SYSDBA in your PDB, create a directory object and grant ORBIT read access:
--      create or replace directory orbit_images as '/opt/oracle/orbit-images';
--      grant read on directory orbit_images to orbit;
-- 3. Run this script as ORBIT.

declare
    l_file  bfile;
    l_blob  blob;
    l_dest  integer;
    l_src   integer;
begin
    for p in (select product_id, sku from orb_products) loop
        l_file := bfilename('ORBIT_IMAGES', p.sku || '.jpg');
        if dbms_lob.fileexists(l_file) = 1 then
            update orb_products
               set product_image    = empty_blob(),
                   image_mime_type  = 'image/jpeg',
                   image_filename   = lower(p.sku) || '.jpg',
                   image_updated_on = sysdate
             where product_id = p.product_id
            returning product_image into l_blob;
            dbms_lob.fileopen(l_file, dbms_lob.file_readonly);
            l_dest := 1; l_src := 1;
            dbms_lob.loadblobfromfile(l_blob, l_file, dbms_lob.getlength(l_file), l_dest, l_src);
            dbms_lob.fileclose(l_file);
        end if;
    end loop;
    commit;
end;
/
select count(*) as products_with_images from orb_products where product_image is not null;
