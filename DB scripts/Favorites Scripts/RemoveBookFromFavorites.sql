ALTER PROCEDURE RemoveFromFavorite
    @UserID INT,
    @BookID INT,
    @Success BIT OUTPUT, -- Adding an output parameter for success
    @Message NVARCHAR(255) OUTPUT -- Adding an output parameter for the message
AS
BEGIN
    SET @Success = 0; -- Initialize as unsuccessful
    SET @Message = 'Operation failed.'; -- Default error message

    -- Check for the existence of the user with the given UserID
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        SET @Message = 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Check for the existence of the book with the given BookID
    IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
    BEGIN
        SET @Message = 'BookID ' + CAST(@BookID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Check if the book is not in the user's favorites
    IF NOT EXISTS (SELECT 1 FROM Favorites WHERE UserID = @UserID AND BookID = @BookID)
    BEGIN
        SET @Message = 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' is not in favorites for UserID ' + CAST(@UserID AS VARCHAR(10)) + '.';
        RETURN;
    END

    -- Remove the book from favorites
    DELETE FROM Favorites
    WHERE UserID = @UserID AND BookID = @BookID;

    -- Set the operation as successful and return a success message
    SET @Success = 1;
    SET @Message = 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' removed from favorites for UserID ' + CAST(@UserID AS VARCHAR(10)) + ' successfully.';
END;
