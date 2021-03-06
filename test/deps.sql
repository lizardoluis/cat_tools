-- Note: pgTap is loaded by setup.sql
/*
CREATE EXTENSION cat_tools VERSION '0.1.0';
ALTER EXTENSION cat_tools UPDATE;
*/
CREATE EXTENSION cat_tools;

-- Add any test dependency statements here

-- Used by several unit tests
\set no_use_role cat_tools_testing__no_use_role
\set use_role cat_tools_testing__use_role
CREATE ROLE :no_use_role;
CREATE ROLE :use_role;

GRANT cat_tools__usage TO :use_role;

