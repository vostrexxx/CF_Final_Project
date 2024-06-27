BEGIN TRY
	INSERT INTO Users (PhoneNumber, OTPCode) VALUES
		('1234567890', '123456'),
		('0987654321', '654321'),
		('1122334455', '112233'),
		('5566778899', '445566'),
		('6677889900', '778899');
END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
	INSERT INTO Authors (Name) VALUES
	('Author One'),
	('Author Two'),
	('Author Three');
	END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
	INSERT INTO Genres (GenreName) VALUES
	('Fiction'),
	('Non-Fiction'),
	('Science Fiction');
	END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
	INSERT INTO Books (Title, AuthorID, GenreID, Price, PublicationYear, PageCount, BindingType, CoverImage) VALUES
	('Book One', 1, 1, 19.99, 2021, 300, 'Hardcover', 'cover1.jpg'),
	('Book Two', 2, 2, 9.99, 2020, 150, 'Paperback', 'cover2.jpg'),
	('Book Three', 3, 3, 14.99, 2019, 250, 'Hardcover', 'cover3.jpg'),
	('Book Four', 1, 1, 24.99, 2022, 320, 'Hardcover', 'cover4.jpg'),
	('Book Five', 2, 2, 7.99, 2018, 120, 'Paperback', 'cover5.jpg');
	END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
	INSERT INTO Favorites (UserID, BookID) VALUES
	(1, 1),
	(1, 3),
	(2, 2),
	(2, 4),
	(3, 1),
	(3, 5),
	(4, 3),
	(4, 4),
	(5, 2),
	(5, 5);
	END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
	INSERT INTO Cart (UserID) VALUES
	(1),
	(2),
	(3),
	(4),
	(5);
	END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH

BEGIN TRY
	INSERT INTO CartBooks (CartID, BookID, Quantity) VALUES
	(1, 1, 2),
	(1, 2, 1),
	(2, 3, 1),
	(2, 4, 3),
	(3, 1, 1),
	(3, 5, 2),
	(4, 4, 1),
	(4, 2, 2),
	(5, 3, 1),
	(5, 5, 1);
	END TRY
BEGIN CATCH
    SELECT 
        ERROR_NUMBER() AS ErrorNumber,
        ERROR_MESSAGE() AS ErrorMessage;
END CATCH