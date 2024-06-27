CREATE FUNCTION dbo.GetBookDetails(@BookID INT)
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
        b.BindingType,
        b.CoverImage
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID
    WHERE
        b.BookID = @BookID
);
