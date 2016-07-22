\set ECHO none

\i test/setup.sql

\set s cat_tools
\set function_array_text '{trigger__get_oid,trigger__get_oid__loose,trigger__parse}'
\set function_array array[:'function_array_text'::name[]]

SELECT plan(5);

SET LOCAL ROLE :no_use_role;

SELECT throws_ok(
      format(
        $$SELECT %I.%I( %L )$$
        , :'s', f
        , 'x'
      )
      , '42501'
      , NULL
      , 'Verify public has no perms'
    )
  FROM unnest(:function_array) f
;

SET LOCAL ROLE :use_role;

CREATE TEMP TABLE "test table"();

SELECT is(
  cat_tools.trigger__get_oid__loose('"test table"', '"test trigger"')
  , NULL
  , 'loose returns NULL for missing trigger'
);
SELECT throws_ok(
  format(
    $$SELECT %I.%I( %L, %L )$$
    , :'s', 'trigger__get_oid'
    , '"test table"'
    , '"test trigger"'
  )
  , 'trigger "test trigger" on table "test table" does not exist'
);

\i test/pgxntool/finish.sql

-- vi: expandtab ts=2 sw=2
