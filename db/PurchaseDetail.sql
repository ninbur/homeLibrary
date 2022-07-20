DROP TABLE IF EXISTS homelibrary.purchaseDetail;
CREATE TABLE homelibrary.purchaseDetail(
	id_purchase SERIAL PRIMARY key,
	price NUMERIC(8,2),
	purchase_place VARCHAR(30),
	id_purchase_date INT
);
ALTER TABLE homelibrary.purchaseDetail OWNER TO homelibrary_group;
