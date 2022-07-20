DROP TABLE IF EXISTS homelibrary.publisher;
CREATE TABLE homelibrary.publisher(
	id_publisher SERIAL PRIMARY KEY,
	name VARCHAR(200) NOT NULL,
	city VARCHAR(100),
	foundation_year SMALLINT CHECK (foundation_year BETWEEN 1900 AND 2022)
);
ALTER TABLE homelibrary.publisher OWNER TO homelibrary_group;
