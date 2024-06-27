IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Users')
BEGIN
	CREATE TABLE Users (
		UserID INT PRIMARY KEY IDENTITY(1,1),
		PhoneNumber VARCHAR(20) UNIQUE NOT NULL,
		OTPCode VARCHAR(10)
	);
    PRINT 'Table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'Table already exists.';
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Authors')
BEGIN
	CREATE TABLE Authors (
		AuthorID INT PRIMARY KEY IDENTITY(1,1),
		Name VARCHAR(100) NOT NULL
	);
    PRINT 'Table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'Table already exists.';
END;

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Genres')
BEGIN
	CREATE TABLE Genres (
		GenreID INT PRIMARY KEY IDENTITY(1,1),
		GenreName VARCHAR(50) NOT NULL
	);
    PRINT 'Table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'Table already exists.';
END;

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

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Cart')
BEGIN
	CREATE TABLE Cart (
		CartID INT PRIMARY KEY IDENTITY(1,1),
		UserID INT NOT NULL,
		FOREIGN KEY (UserID) REFERENCES Users(UserID)
	);
    PRINT 'Table has been successfully created.';
END
ELSE
BEGIN
    PRINT 'Table already exists.';
END;

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



