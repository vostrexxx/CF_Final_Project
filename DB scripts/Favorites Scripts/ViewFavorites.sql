ALTER PROCEDURE ViewFavorites
    @UserID INT
AS
BEGIN
    -- Проверка существования пользователя с заданным UserID
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        PRINT 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Выбор избранных книг пользователя
    SELECT 
        b.Title,
        a.Name AS Author,
        g.GenreName,
        b.Price,
        b.PublicationYear,
        b.PageCount,
        b.CoverImage
    FROM 
        Favorites f
    INNER JOIN 
        Books b ON f.BookID = b.BookID
    INNER JOIN 
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN 
        Genres g ON b.GenreID = g.GenreID
    WHERE 
        f.UserID = @UserID;
END;
