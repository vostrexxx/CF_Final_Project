IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CartBooks')
BEGIN
	CREATE TABLE CartBooks (
		CartID INT NOT NULL,
		BookID INT NOT NULL,
		Quantity INT NOT NULL,
		PRIMARY KEY (CartID, BookID),
		FOREIGN KEY (CartID) REFERENCES Cart(CartID),
		FOREIGN KEY (BookID) REFERENCES Books(BookID)
	);
    PRINT 'Table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'Table already exists.';
END;
