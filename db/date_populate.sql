INSERT INTO homelibrary.purchasedate (id_purchase_date,
                                        day_int, 
                                        day_of_week,
                                        month_int,
                                        quartile,
                                        year_int)
(SELECT 
  CAST (to_char (t, 'YYYYMMDD') AS int) ,
  EXTRACT (day FROM t),
  EXTRACT (isodow FROM t),
  EXTRACT (month FROM t),
  EXTRACT (quarter FROM t),
  EXTRACT (year FROM t)
  FROM generate_series('2000-01-01'::timestamp, '2023-12-31', '24hours'::interval) AS t);