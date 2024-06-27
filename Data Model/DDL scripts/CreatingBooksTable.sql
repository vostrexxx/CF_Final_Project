IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Books')
BEGIN
	CREATE TABLE Books (
		BookID INT PRIMARY KEY IDENTITY(1,1),
		Title VARCHAR(100) NOT NULL,
		AuthorID INT NOT NULL,
		GenreID INT NOT NULL,
		Price DECIMAL(10, 2) NOT NULL,
		PublicationYear INT,
		PageCount INT,
		BindingType VARCHAR(20),
		CoverImage VARCHAR(255),
		FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID),
		FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
	);
    PRINT 'Table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'Table already exists.';
END;