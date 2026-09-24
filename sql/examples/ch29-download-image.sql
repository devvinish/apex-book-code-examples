-- Chapter 29: Download Image (page 12, Download, Before Header, Request = DOWNLOAD_IMAGE)
-- Columns: file content, file name, MIME type
select product_image, image_filename, image_mime_type
  from orb_products
 where product_id = :P12_PRODUCT_ID
