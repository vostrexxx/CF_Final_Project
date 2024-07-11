ALTER FUNCTION dbo.GetBookDetails(@UserID INT, @BookID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        b.Title AS BookTitle, 
        a.Name AS AuthorName, 
        g.GenreName AS Genre, 
        b.Price, 
        b.PublicationYear, 
        b.PageCount, 
<<<<<<< HEAD
        b.BindingType, 
        b.CoverImage, 
        CASE WHEN cb.BookID IS NOT NULL THEN 1 ELSE 0 END AS InCart,
=======
        b.BindingType,
        b.CoverImage, 
        CASE WHEN cb.BookID IS NOT NULL THEN 1 ELSE 0 END AS InCart, 
>>>>>>> f3e3d3b71d3a9fe9ac167f9667cd0c5f290d3a49
        CASE WHEN f.BookID IS NOT NULL THEN 1 ELSE 0 END AS IsFavorite 
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID
    LEFT JOIN
        CartBooks cb ON b.BookID = cb.BookID AND cb.CartID = (SELECT CartID FROM Cart WHERE UserID = @UserID)
    LEFT JOIN
        Favorites f ON b.BookID = f.BookID AND f.UserID = @UserID
    WHERE
        b.BookID = @BookID
);
