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