CREATE PROCEDURE RemoveFromFavorite
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

    -- Проверка, добавлена ли книга в избранное пользователем
    IF NOT EXISTS (SELECT 1 FROM Favorites WHERE UserID = @UserID AND BookID = @BookID)
    BEGIN
        PRINT 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' is not in favorites for UserID ' + CAST(@UserID AS VARCHAR(10)) + '.';
        RETURN;
    END

    -- Удаление книги из избранного
    DELETE FROM Favorites
    WHERE UserID = @UserID AND BookID = @BookID;

    -- Возвращаем успешное сообщение
    PRINT 'Book with BookID ' + CAST(@BookID AS VARCHAR(10)) + ' removed from favorites for UserID ' + CAST(@UserID AS VARCHAR(10)) + ' successfully.';
END;
