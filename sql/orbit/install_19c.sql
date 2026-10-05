-- Installs the Orbit Outfitters sample schema on Oracle Database 19c. Run as ORBIT:
--   sql orbit@localhost:1521/ORCLPDB1 @install_19c.sql
-- The yes/no columns are VARCHAR2(1) with 'Y' and 'N'. The order duality view of
-- Chapter 40 (07_duality.sql) needs Oracle AI Database 26ai and is left out.
set define off
prompt Creating tables...
@@01_tables_19c.sql
prompt Creating triggers, package, and views...
@@02_logic.sql
prompt Loading sample data (about a minute)...
@@03_data_19c.sql
prompt Creating application users and password checking (Chapter 35; needs execute on sys.dbms_crypto)...
@@06_auth.sql
prompt Orbit Outfitters sample schema installed.
