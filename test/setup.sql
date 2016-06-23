-- Pulls in deps.sql
\i test/pgxntool/setup.sql

GRANT USAGE ON SCHEMA tap TO :use_role, :no_use_role;
