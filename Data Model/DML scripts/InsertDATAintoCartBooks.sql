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