SELECT
  *,
  'Table_1' AS source_
FROM
  Table_1 AS t1
WHERE
  NOT EXISTS (
    SELECT
      *
    FROM
      Table_2 AS t2
    WHERE
      t2.item_code = t1.item_code
      AND t2.attr_1 = t1.attr_1
      AND t2.attr_2 = t1.attr_2
      AND t2.attr_3 = t1.attr_3
      AND t2.attr_4 = t1.attr_4
      AND t2.attr_5 = t1.attr_5
  )
UNION
SELECT
  *,
  'Table_2' AS source_
FROM
  Table_2 AS t2
WHERE
  NOT exists (
    SELECT
      *
    FROM
      Table_1 AS t1
    WHERE
      t2.item_code = t1.item_code
      AND t2.attr_1 = t1.attr_1
      AND t2.attr_2 = t1.attr_2
      AND t2.attr_3 = t1.attr_3
      AND t2.attr_4 = t1.attr_4
      AND t2.attr_5 = t1.attr_5
  );


SELECT
  *
FROM
  (
    SELECT
      *
    FROM
      Table_1
    UNION ALL
    SELECT
      *
    FROM
      Table_2
  ) AS foo
GROUP BY
  item_code,
  attr_1,
  attr_2,
  attr_3,
  attr_4,
  attr_5
HAVING
  COUNT(*) = 1;
