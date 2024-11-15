-- set variables (these need to be uppercase)
-- set $airbyte_role = 'AIRBYTE_ROLE';
-- set $airbyte_username = 'AIRBYTE_USER';
-- set $airbyte_warehouse = 'AIRBYTE_WAREHOUSE';
-- set $airbyte_database = 'AIRBYTE_DATABASE';
-- set $airbyte_schema = 'AIRBYTE_SCHEMA';
-- set $airbyte_password = 'Test12345';

begin;

-- create Airbyte role
use role securityadmin;
create role if not exists identifier('AIRBYTE_ROLE');
grant role identifier('AIRBYTE_ROLE') to role SYSADMIN;

-- create Airbyte user
create user if not exists identifier('AIRBYTE_USER')
password = 'Test12345'
default_role = 'AIRBYTE_ROLE'
default_warehouse = 'AIRBYTE_WAREHOUSE';

grant role identifier('AIRBYTE_ROLE') to user identifier('AIRBYTE_USER');

-- change role to sysadmin for warehouse / database steps
use role sysadmin;

-- create Airbyte warehouse
create warehouse if not exists identifier('AIRBYTE_WAREHOUSE')
warehouse_size = xsmall
warehouse_type = standard
auto_suspend = 60
auto_resume = true
initially_suspended = true;

-- create Airbyte database
create database if not exists identifier('AIRBYTE_DATABASE');

-- grant Airbyte warehouse access
grant USAGE
on warehouse identifier('AIRBYTE_WAREHOUSE')
to role identifier('AIRBYTE_ROLE');

-- grant Airbyte database access
grant OWNERSHIP
on database identifier('AIRBYTE_DATABASE')
to role identifier('AIRBYTE_ROLE');

commit;

begin;

USE DATABASE identifier('AIRBYTE_DATABASE');

-- create schema for Airbyte data
CREATE SCHEMA IF NOT EXISTS identifier('AIRBYTE_SCHEMA');

commit;

begin;

-- grant Airbyte schema access
grant OWNERSHIP
on schema identifier('AIRBYTE_SCHEMA')
to role identifier('AIRBYTE_ROLE');

commit;