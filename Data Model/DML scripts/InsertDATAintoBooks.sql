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