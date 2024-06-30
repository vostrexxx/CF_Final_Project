ALTER PROCEDURE ViewFavorites
    @UserID INT
AS
BEGIN
    -- Check for the existence of the user with the given UserID
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        PRINT 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Select the user's favorite books
    SELECT 
        b.Title, -- The title of the book
        a.Name AS Author, -- The name of the author
        g.GenreName, -- The genre of the book
        b.Price, -- The price of the book
        b.PublicationYear, -- The year of publication
        b.PageCount, -- The number of pages
        b.CoverImage -- The cover image of the book
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
