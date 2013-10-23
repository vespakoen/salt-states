DO
$func$
BEGIN
   EXECUTE (
      SELECT 'TRUNCATE TABLE '
             || array_to_string(array_agg(t.tablename), ', ')
             || ' CASCADE'
      FROM   pg_tables t
      WHERE  t.schemaname = 'public'
      AND t.tableowner = 'trapps'
   );
END
$func$;
