DROP TABLE IF EXISTS homelibrary.series;
CREATE TABLE homelibrary.series(
	id_series SERIAL PRIMARY KEY,
	name VARCHAR(200),
	id_author INT,
	id_publisher INT
);
ALTER TABLE homelibrary.series OWNER TO homelibrary_group;
