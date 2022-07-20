DROP TABLE IF EXISTS homelibrary.purchaseDate;
CREATE TABLE homelibrary.purchaseDate(
	id_purchase_date INT PRIMARY KEY,
	day_int SMALLINT,
	day_of_week SMALLINT,
	month_int SMALLINT,
	week_int SMALLINT,
	quartile SMALLINT,
	year_int SMALLINT
);
ALTER TABLE homelibrary.purchaseDate OWNER TO homelibrary_group;
