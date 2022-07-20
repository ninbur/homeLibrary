DROP TABLE IF EXISTS homelibrary.friends;
CREATE TABLE homelibrary.friends(
	id_friend SERIAL PRIMARY KEY ,
	name_friend VARCHAR(30) NOT NULL,
	phone INT,
	email VARCHAR(50)
);
ALTER TABLE homelibrary.friends OWNER TO homelibrary_group;