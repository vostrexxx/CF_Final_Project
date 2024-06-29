CREATE PROCEDURE [dbo].[SearchBooksByTitleOrAuthor]
    @SearchTerm NVARCHAR(255)
AS
BEGIN
    SELECT 
        b.BookID,
        b.Title AS Book_Title,
        a.Name AS Author,
        g.GenreName AS Genre,
        b.Price,
        b.CoverImage AS Cover_Image
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID
    WHERE 
        b.Title LIKE '%' + @SearchTerm + '%'
        OR a.Name LIKE '%' + @SearchTerm + '%'
END;

