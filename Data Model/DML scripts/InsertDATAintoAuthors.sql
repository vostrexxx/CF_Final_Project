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
