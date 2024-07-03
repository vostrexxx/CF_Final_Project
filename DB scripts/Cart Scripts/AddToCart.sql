ALTER PROCEDURE AddToCart
    @UserID INT,
    @BookID INT,
    @Quantity INT,
    @Success BIT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
AS
BEGIN
    SET @Success = 0; -- Default to failure
    SET @Message = 'Unknown error'; -- Default message

    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        SET @Message = 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
    BEGIN
        SET @Message = 'BookID ' + CAST(@BookID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    DECLARE @CartID INT;
    SELECT @CartID = CartID FROM Cart WHERE UserID = @UserID;

    IF @CartID IS NULL
    BEGIN
        INSERT INTO Cart (UserID) VALUES (@UserID);
        SELECT @CartID = SCOPE_IDENTITY();
    END

    IF EXISTS (SELECT 1 FROM CartBooks WHERE CartID = @CartID AND BookID = @BookID)
    BEGIN
        UPDATE CartBooks SET Quantity = Quantity + @Quantity WHERE CartID = @CartID AND BookID = @BookID;
    END
    ELSE
    BEGIN
        INSERT INTO CartBooks (CartID, BookID, Quantity) VALUES (@CartID, @BookID, @Quantity);
    END

    SET @Success = 1; -- Success
    SET @Message = 'Book added to cart successfully.';
END;
GO
