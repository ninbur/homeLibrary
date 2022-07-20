SELECT *
FROM homelibrary.books
LIMIT 5;
SELECT *
FROM homelibrary.purchasedate p 
LIMIT 5;
SELECT *
FROM homelibrary.friends f 
LIMIT 5;

SELECT *
FROM homelibrary.books 
WHERE id_lend IS NOT NULL;

SELECT *
FROM homelibrary.lend 
LIMIT 10;

DELETE FROM homelibrary.lend
WHERE id_lend IS NOT NULL;

INSERT INTO homelibrary.lend (id_friend, lend_date)
SELECT
	f.id_friend,
	current_date 
FROM homelibrary.friends f 
WHERE name_friend = 'Mama'
ON CONFLICT DO NOTHING ;

UPDATE homelibrary.books
SET id_lend = (SELECT l.id_lend
	FROM homelibrary.lend  l
	INNER JOIN homelibrary.friends f ON l.id_friend=f.id_friend
	WHERE f.name_friend='Mama' AND L.id_lend=(SELECT max(id_lend) FROM homelibrary.lend))
WHERE id_book = 206;

INSERT INTO homelibrary.lend (id_friend, lend_date)
SELECT
	f.id_friend,
	current_date 
FROM homelibrary.friends f 
WHERE name_friend = 'Patrycja W.'
ON CONFLICT DO NOTHING ;

UPDATE homelibrary.books
SET id_lend = (SELECT l.id_lend
	FROM homelibrary.lend  l
	INNER JOIN homelibrary.friends f ON l.id_friend=f.id_friend
	WHERE f.name_friend='Patrycja W.' AND L.id_lend=(SELECT max(id_lend) FROM homelibrary.lend))
WHERE id_book = 192;

INSERT INTO homelibrary.lend (id_friend, lend_date)
SELECT
	f.id_friend,
	current_date 
FROM homelibrary.friends f 
WHERE name_friend = 'Patrycja W.'
ON CONFLICT DO NOTHING ;

UPDATE homelibrary.books
SET id_lend = (SELECT l.id_lend
	FROM homelibrary.lend  l
	INNER JOIN homelibrary.friends f ON l.id_friend=f.id_friend
	WHERE f.name_friend='Patrycja W.' AND L.id_lend=(SELECT max(id_lend) FROM homelibrary.lend))
WHERE id_book = 37;

ALTER TABLE homelibrary.books
DROP COLUMN id_lend;

UPDATE homelibrary.lend 
SET id_book = 37
WHERE id_lend=14;

--UPDATE homelibrary.books
--SET id_lend = NULL
--WHERE id_lend IS NOT NULL;