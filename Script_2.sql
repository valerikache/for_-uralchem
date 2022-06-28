SELECT
  item_code,
  MD5(values_) AS md_5
FROM
  (
   SELECT
     item_code,
     STRING_AGG (attr_name || ' ' || value, ','
       ORDER BY
         item_code,
         attr_name,
         value
         ) AS values_
	FROM
      Table_3
	GROUP BY
	  item_code
  ) AS foo
ORDER by
  md_5; 
 

WITH data AS (
  SELECT
    item_code,
    MD5(values_) AS md_5
  FROM
    (
     SELECT
       item_code,
       STRING_AGG (attr_name || ' ' || value, ','
         ORDER BY
           item_code,
           attr_name,
           value
           ) AS values_
	 FROM
       Table_3
	 GROUP BY
	   item_code
    ) AS foo

)
SELECT
  * 
FROM
  data
WHERE 
  md_5 IN (
           SELECT 
             md_5 
           FROM
             data
		   GROUP BY 
		     md_5
		   HAVING 
		     COUNT(md_5) > 1
		  );
				
 