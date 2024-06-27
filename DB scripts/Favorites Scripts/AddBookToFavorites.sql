ALTER PROCEDURE AddToFavorite
    @UserID INT,
    @BookID INT
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

    -- Проверка, не добавлена ли уже книга в избранное пользователем
    IF EXISTS (SELECT 1 FROM Favorites WHERE UserID = @UserID AND BookID = @BookID)
    BEGIN
        PRINT 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' is already in favorites for UserID ' + CAST(@UserID AS VARCHAR(10)) + '.';
        RETURN;
    END

    -- Добавление книги в избранное
    INSERT INTO Favorites (UserID, BookID)
    VALUES (@UserID, @BookID);

    -- Возвращаем успешное сообщение
    PRINT 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' added to favorites for UserID ' + CAST(@UserID AS VARCHAR(10)) + ' successfully.';
END;
