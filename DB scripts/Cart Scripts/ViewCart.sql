ALTER PROCEDURE ViewCart
    @UserID INT
AS
BEGIN
    -- Убедимся, что нет открытых курсоров и удаляем временные таблицы
    IF OBJECT_ID('tempdb..#CartDetails') IS NOT NULL
    BEGIN
        DROP TABLE #CartDetails;
    END
    
    -- Проверка существования пользователя с заданным UserID
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        PRINT 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Создаем временную таблицу для хранения результатов
    CREATE TABLE #CartDetails (
        Title VARCHAR(100),
        Author VARCHAR(100),
        Price DECIMAL(10, 2),
        Quantity INT,
        TotalPrice DECIMAL(10, 2)
    );

    -- Вставляем данные во временную таблицу
    INSERT INTO #CartDetails
    SELECT 
        b.Title,
        a.Name AS Author,
        b.Price,
        cb.Quantity,
        (b.Price * cb.Quantity) AS TotalPrice
    FROM 
        Cart c
    JOIN 
        CartBooks cb ON c.CartID = cb.CartID
    JOIN 
        Books b ON cb.BookID = b.BookID
    JOIN
        Authors a ON b.AuthorID = a.AuthorID
    WHERE 
        c.UserID = @UserID;

    -- Возвращаем результаты
    SELECT * FROM #CartDetails;

    -- Удаляем временную таблицу
    DROP TABLE #CartDetails;
END;
