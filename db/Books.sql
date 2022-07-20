DROP TABLE IF EXISTS homelibrary.books;
CREATE TABLE homelibrary.books(
	id_book SERIAL PRIMARY key,
	ISBN BIGINT NOT NULL,
	id_lend INT,
	id_placement INT,
	id_purchase INT
);
ALTER TABLE homelibrary.books OWNER TO homelibrary_group;
