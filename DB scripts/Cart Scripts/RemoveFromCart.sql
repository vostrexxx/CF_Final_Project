ALTER PROCEDURE RemoveFromCart
    -- Parameters: User ID, Book ID, and Quantity
    @UserID INT,
    @BookID INT,
    @Quantity INT,
    -- Output parameter to track success
    @Success BIT OUTPUT,
    -- Output parameter for the message
    @Message NVARCHAR(255) OUTPUT
AS
BEGIN
    -- Initialize as unsuccessful
    SET @Success = 0;
    -- Initialize error message
    SET @Message = 'Operation failed.';

    -- Check if a user with the given UserID exists
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        -- If user does not exist, set error message and exit
        SET @Message = 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Check if a book with the given BookID exists
    IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
    BEGIN
        -- If book does not exist, set error message and exit
        SET @Message = 'BookID ' + CAST(@BookID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Check for an existing cart for the user
    DECLARE @CartID INT;
    SELECT @CartID = CartID FROM Cart WHERE UserID = @UserID;

    -- If no cart exists, set error message and exit
    IF @CartID IS NULL
    BEGIN
        SET @Message = 'Cart does not exist for UserID ' + CAST(@UserID AS VARCHAR(10)) + '.';
        RETURN;
    END

    -- Check if the book is in the user's cart
    DECLARE @ExistingQuantity INT;
    SELECT @ExistingQuantity = Quantity
    FROM CartBooks
    WHERE CartID = @CartID AND BookID = @BookID;

    -- If the book is not in the cart, set error message and exit
    IF @ExistingQuantity IS NULL
    BEGIN
        SET @Message = 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' does not exist in the cart.';
        RETURN;
    END

    -- If the requested quantity exceeds the available quantity, set error message and exit
    IF @Quantity > @ExistingQuantity
    BEGIN
        SET @Message = 'Requested quantity exceeds the available quantity in the cart.';
        RETURN;
    END

    -- Remove the specified quantity of books from the cart
    UPDATE CartBooks
    SET Quantity = Quantity - @Quantity
    WHERE CartID = @CartID AND BookID = @BookID;

    -- If the quantity drops to zero, remove the entry from the cart
    DELETE FROM CartBooks
    WHERE CartID = @CartID AND BookID = @BookID AND Quantity <= 0;

    -- Set the operation as successful and return a success message
    SET @Success = 1;
    SET @Message = 'Books removed from cart successfully.';
END;