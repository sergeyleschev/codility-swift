-- Solution @ Sergey Leschev, Belarusian State University

-- SQL. SqlSum.

-- Given a table elements with the following structure:
--   create table elements (
--       v integer not null
--   );
-- write an SQL query that returns the sum of the numbers in column v.

-- For example, given:
--   v
--   ---
--   2
--   10
--   20
--   10
-- your query should return 42.

select sum(v) from elements