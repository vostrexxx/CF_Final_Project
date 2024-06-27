-- Создаем процедуру AddToCart
ALTER PROCEDURE AddToCart
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
        -- Если корзины нет, создаем новую
        INSERT INTO Cart (UserID)
        VALUES (@UserID);

        SELECT @CartID = SCOPE_IDENTITY(); -- Получаем ID новой корзины
    END

    -- Проверяем, есть ли уже такая книга в корзине
    IF EXISTS (SELECT 1 FROM CartBooks WHERE CartID = @CartID AND BookID = @BookID)
    BEGIN
        -- Если книга уже есть в корзине, обновляем количество
        UPDATE CartBooks
        SET Quantity = Quantity + @Quantity
        WHERE CartID = @CartID AND BookID = @BookID;
    END
    ELSE
    BEGIN
        -- Если книги нет в корзине, добавляем новую запись
        INSERT INTO CartBooks (CartID, BookID, Quantity)
        VALUES (@CartID, @BookID, @Quantity);
    END

    -- Возвращаем успешное сообщение
    PRINT 'Book added to cart successfully.';
END;
GO