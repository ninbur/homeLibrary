DROP TABLE IF EXISTS homelibrary.cover;
CREATE TABLE homelibrary.cover(
	id_cover SERIAL PRIMARY KEY,
	image bytea
);
ALTER TABLE homelibrary.cover OWNER TO homelibrary_group;
