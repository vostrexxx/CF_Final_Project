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