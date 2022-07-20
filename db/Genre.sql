DROP TABLE IF EXISTS homelibrary.genre;
CREATE TABLE homelibrary.genre(
	genre_name VARCHAR(30) PRIMARY KEY,
	type_name VARCHAR(10)
);
ALTER TABLE homelibrary.genre OWNER TO homelibrary_group;
