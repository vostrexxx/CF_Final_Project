ALTER PROCEDURE RemoveFromCart
    @UserID INT,
    @BookID INT,
    @Quantity INT
AS
BEGIN
    -- Проверка существования пользователя с заданным UserID
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        PRINT 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Проверка существования книги с заданным BookID
    IF NOT EXISTS (SELECT 1 FROM Books WHERE BookID = @BookID)
    BEGIN
        PRINT 'BookID ' + CAST(@BookID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Проверка наличия уже существующей корзины для пользователя
    DECLARE @CartID INT;
    SELECT @CartID = CartID FROM Cart WHERE UserID = @UserID;

    IF @CartID IS NULL
    BEGIN
        PRINT 'Cart does not exist for UserID ' + CAST(@UserID AS VARCHAR(10)) + '.';
        RETURN;
    END

    -- Проверка наличия книги в корзине пользователя
    DECLARE @ExistingQuantity INT;
    SELECT @ExistingQuantity = Quantity
    FROM CartBooks
    WHERE CartID = @CartID AND BookID = @BookID;

    IF @ExistingQuantity IS NULL
    BEGIN
        PRINT 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' does not exist in the cart.';
        RETURN;
    END

    -- Проверка достаточного количества книг для удаления
    IF @Quantity > @ExistingQuantity
    BEGIN
        PRINT 'Requested quantity exceeds the available quantity in the cart.';
        RETURN;
    END

    -- Удаляем указанное количество книг из корзины
    UPDATE CartBooks
    SET Quantity = Quantity - @Quantity
    WHERE CartID = @CartID AND BookID = @BookID;

    -- Если количество книг упало до нуля, удаляем запись из корзины
    DELETE FROM CartBooks
    WHERE CartID = @CartID AND BookID = @BookID AND Quantity <= 0;

    -- Возвращаем успешное сообщение
    PRINT 'Books removed from cart successfully.';
END;