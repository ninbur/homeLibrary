DROP TABLE IF EXISTS homelibrary_stg.books_stage;
CREATE TABLE homelibrary_stg.books_stage(
	isbn BIGINT NOT NULL,
    title VARCHAR(200) NOT NULL,
    publish_date TIMESTAMP,
    no_pages SMALLINT,
    series VARCHAR(200),
    author VARCHAR(60),
    publisher VARCHAR(200),
    description VARCHAR(2500),
    read_date DATE,
    rating NUMERIC(4,2),
    genre_name VARCHAR(30),
    cover_image bytea,
    country_author VARCHAR(70),
    birthday_author DATE,
    city_publisher VARCHAR(100),
    foundation_year_publisher SMALLINT,
    price NUMERIC(6,2),
    purchase_place VARCHAR(30),
    id_purchase_date DATE,
    shelf SMALLINT,
    bookcase CHAR(1),
    room SMALLINT
);
ALTER TABLE homelibrary_stg.books_stage OWNER TO homelibrary_group;