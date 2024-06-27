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