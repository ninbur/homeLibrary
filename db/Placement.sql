DROP TABLE IF EXISTS homelibrary.placement;
CREATE TABLE homelibrary.placement(
	id_placement SERIAL PRIMARY KEY,
	shelf SMALLINT,
	bookcase CHAR(1),
	room SMALLINT
);
ALTER TABLE homelibrary.placement OWNER TO homelibrary_group;
