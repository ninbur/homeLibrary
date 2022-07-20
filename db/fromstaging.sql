
INSERT INTO homelibrary.author (name, country, birthday)
SELECT 
	author,
	country_author,
	birthday_author
FROM homelibrary_stg.books_stage bs
WHERE bs.author NOT IN (SELECT name FROM homelibrary.author);

INSERT INTO homelibrary.publisher (name, city, foundation_year)
SELECT 
	publisher,
	city_publisher,
	foundation_year_publisher
FROM homelibrary_stg.books_stage bs
WHERE bs.publisher NOT IN (SELECT name FROM homelibrary.publisher);

INSERT INTO homelibrary.series (name, id_author, id_publisher)
SELECT 
	bs.series,
	a.id_author,
	p.id_publisher
FROM homelibrary_stg.books_stage bs
LEFT JOIN homelibrary.author a ON bs.author = a."name" AND bs.country_author =a.country AND bs.birthday_author = a.birthday 
LEFT JOIN homelibrary.publisher p ON bs.publisher =p."name" AND bs.city_publisher=p.city AND bs.foundation_year_publisher =p.foundation_year;

INSERT INTO homelibrary.cover (image)
SELECT 
	bs.cover_image 
FROM homelibrary_stg.books_stage bs
WHERE bs.cover_image NOT IN (SELECT image FROM homelibrary.cover)
	AND bs.cover_image IS NOT NULL;

INSERT INTO homelibrary.bookdetails (isbn, title, id_cover, publish_date, no_pages, 
	description, read_date, rating, id_series, genre_name)
SELECT 
	DISTINCT ON (bs.isbn) isbn,
	bs.title,
	c.id_cover,
	bs.publish_date,
	bs.no_pages,
	bs.description,
	bs.read_date,
	bs.rating,
	s.id_series,
	bs.genre_name 
FROM homelibrary_stg.books_stage bs
	LEFT JOIN homelibrary.cover c ON bs.cover_image = c.image 
	LEFT JOIN homelibrary.series s ON bs.series=s."name"
	LEFT JOIN homelibrary.author a ON bs.author = a."name" AND bs.country_author =a.country AND bs.birthday_author = a.birthday 
	LEFT JOIN homelibrary.publisher p ON bs.publisher = p."name" AND bs.city_publisher=p.city AND bs.foundation_year_publisher =p.foundation_year
WHERE isbn NOT IN (SELECT isbn FROM homelibrary.bookdetails b);

INSERT INTO homelibrary.purchasedetail (price, purchase_place, id_purchase_date)
SELECT 
	bs.price,
	bs.purchase_place,
	CAST(to_char(bs.id_purchase_date, 'YYYYMMDD') AS INT)
FROM homelibrary_stg.books_stage bs;

INSERT INTO homelibrary.placement (shelf, bookcase, room)
SELECT 
	DISTINCT
	bs.shelf,
	bs.bookcase,
	bs.room
FROM homelibrary_stg.books_stage bs
WHERE NOT EXISTS (SELECT id_placement 
				FROM homelibrary.placement p
				WHERE p.shelf=bs.shelf AND p.bookcase=bs.bookcase AND p.room=bs.room);

INSERT INTO homelibrary.books (isbn, id_placement, id_purchase)
SELECT 
	bs.isbn,
	p.id_placement,
	p2.id_purchase 
FROM homelibrary_stg.books_stage bs
LEFT JOIN homelibrary.placement p ON bs.shelf = p.shelf AND bs.bookcase = p.bookcase AND bs.room = p.room 
LEFT JOIN homelibrary.purchasedetail p2 ON bs.price = p2.price AND bs.purchase_place = p2.purchase_place 
	AND CAST(to_char(bs.id_purchase_date, 'YYYYMMDD') AS INT) = p2.id_purchase_date ;