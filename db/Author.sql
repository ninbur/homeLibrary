DROP TABLE IF EXISTS homelibrary.author;
CREATE TABLE homelibrary.author(
	id_author SERIAL PRIMARY KEY,
	name VARCHAR(60),
	country VARCHAR(70),
	birthday TIMESTAMP
);
ALTER TABLE homelibrary.author OWNER TO homelibrary_group;
