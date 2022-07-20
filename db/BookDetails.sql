DROP TABLE IF EXISTS homelibrary.bookDetails;
CREATE TABLE homelibrary.bookDetails(
	ISBN BIGINT PRIMARY KEY,
	title VARCHAR(200) NOT NULL,
	original_title VARCHAR(200),
	id_cover INT,
	publish_date DATE,
	no_pages SMALLINT CHECK (no_pages > 0 AND no_pages < 2000),
	description VARCHAR(2500),
	read_date TIMESTAMP,
	rating NUMERIC(2, 1),
	id_series INT,
	genre_name VARCHAR(30)
);
ALTER TABLE homelibrary.bookDetails OWNER TO homelibrary_group;
