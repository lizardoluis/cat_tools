\set ECHO none

\i test/pgxntool/setup.sql

\set test_enum enum_range_srf_test_enum

SELECT plan(3);

SELECT lives_ok(
  $$CREATE TYPE $$ || :'test_enum' || $$ AS ENUM( 'ZZZ Label 1', 'Label 2' )$$
  , 'Create test enum'
);

-- Tests both functions
SELECT results_eq(
  format( 'SELECT cat_tools.enum_range_srf( %L )', :'test_enum' )
  , $$VALUES ( 'ZZZ Label 1' ), ( 'Label 2' )$$
);

SELECT lives_ok(
  'DROP TYPE ' || :'test_enum'
  , 'Drop test enum'
);

\i test/pgxntool/finish.sql

-- vi: expandtab ts=2 sw=2
