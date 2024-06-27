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
