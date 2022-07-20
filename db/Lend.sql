DROP TABLE IF EXISTS homelibrary.lend CASCADE;
CREATE TABLE homelibrary.lend(
	id_lend SERIAL PRIMARY KEY,
	id_book INT NOT NULL,
	id_friend INT NOT NULL,
	lend_date TIMESTAMP
);
ALTER TABLE homelibrary.lend OWNER TO homelibrary_group;
