IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Favorites')
BEGIN
	CREATE TABLE Favorites (
		UserID INT NOT NULL,
		BookID INT NOT NULL,
		PRIMARY KEY (UserID, BookID),
		FOREIGN KEY (UserID) REFERENCES Users(UserID),
		FOREIGN KEY (BookID) REFERENCES Books(BookID)
	);
    PRINT 'Table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'Table already exists.';
END;