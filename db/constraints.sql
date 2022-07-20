ALTER TABLE homelibrary.bookDetails
    ADD CONSTRAINT fk_bookDetails_genre
    FOREIGN KEY (genre_name) 
    REFERENCES homelibrary.genre(genre_name);
   
ALTER TABLE homelibrary.bookDetails
    ADD CONSTRAINT fk_bookDetails_series
    FOREIGN KEY (id_series) 
    REFERENCES homelibrary.series(id_series);

ALTER TABLE homelibrary.bookDetails
    ADD CONSTRAINT fk_bookDetails_cover
    FOREIGN KEY (id_cover) 
    REFERENCES homelibrary.cover(id_cover);
   
ALTER TABLE homelibrary.series
    ADD CONSTRAINT fk_series_author
    FOREIGN KEY (id_author) 
    REFERENCES homelibrary.author(id_author);

ALTER TABLE homelibrary.series
    ADD CONSTRAINT fk_series_publisher
    FOREIGN KEY (id_publisher)
    REFERENCES homelibrary.publisher(id_publisher);
    
ALTER TABLE homelibrary.books
    ADD CONSTRAINT fk_books_bookdetails
    FOREIGN KEY (isbn)
    REFERENCES homelibrary.bookdetails(isbn);

   
ALTER TABLE homelibrary.lend
    ADD CONSTRAINT fk_lend_books
    FOREIGN KEY (id_book)
    REFERENCES homelibrary.books(id_book);

    
ALTER TABLE homelibrary.books
    ADD CONSTRAINT fk_books_placement
    FOREIGN KEY (id_placement)
    REFERENCES homelibrary.placement(id_placement);
    
ALTER TABLE homelibrary.books
    ADD CONSTRAINT fk_books_purchaseDetail
    FOREIGN KEY (id_purchase)
    REFERENCES homelibrary.purchaseDetail(id_purchase);
    
ALTER TABLE homelibrary.purchaseDetail
    ADD CONSTRAINT fk_purchaseDetail_purchaseDate
    FOREIGN KEY (id_purchase_date)
    REFERENCES homelibrary.purchaseDate(id_purchase_date);
    
ALTER TABLE homelibrary.lend
    ADD CONSTRAINT fk_lend_friends
    FOREIGN KEY (id_friend)
    REFERENCES homelibrary.friends(id_friend);