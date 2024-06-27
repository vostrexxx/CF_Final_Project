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
