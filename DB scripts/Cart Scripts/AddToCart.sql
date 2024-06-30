-- Altering the procedure 'AddToCart'
ALTER PROCEDURE AddToCart
    -- Parameters: User ID, Book ID, and Quantity
    @UserID INT,
    @BookID INT,
    @Quantity INT
AS
BEGIN
    -- Check if a user with the given UserID exists
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        -- If user does not exist, print an error message and exit
        PRINT 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Check if a book with the given BookID exists
    IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
    BEGIN
        -- If book does not exist, print an error message and exit
        PRINT 'BookID ' + CAST(@BookID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Check for an existing cart for the user
    DECLARE @CartID INT;
    SELECT @CartID = CartID FROM Cart WHERE UserID = @UserID;

    -- If no cart exists, create a new one
    IF @CartID IS NULL
    BEGIN
        INSERT INTO Cart (UserID)
        VALUES (@UserID);
        -- Retrieve the ID of the new cart
        SELECT @CartID = SCOPE_IDENTITY();
    END

    -- Check if the book is already in the cart
    IF EXISTS (SELECT 1 FROM CartBooks WHERE CartID = @CartID AND BookID = @BookID)
    BEGIN
        -- If the book is in the cart, update the quantity
        UPDATE CartBooks
        SET Quantity = Quantity + @Quantity
        WHERE CartID = @CartID AND BookID = @BookID;
    END
    ELSE
    BEGIN
        -- If the book is not in the cart, add a new entry
        INSERT INTO CartBooks (CartID, BookID, Quantity)
        VALUES (@CartID, @BookID, @Quantity);
    END

    -- Print a success message
    PRINT 'Book added to cart successfully.';
END;
GO
