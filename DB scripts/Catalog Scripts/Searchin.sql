CREATE PROCEDURE [dbo].[SearchBooksByTitleOrAuthor]
    @SearchTerm NVARCHAR(255)
AS
BEGIN
    SELECT 
        b.Title AS Book_Title, -- The title of the book
        a.Name AS Author, -- The name of the author
        g.GenreName AS Genre, -- The genre of the book
        b.Price, -- The price of the book
        b.CoverImage AS Cover_Image -- The cover image of the book
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID
    WHERE 
        b.Title LIKE '%' + @SearchTerm + '%' -- Search for books with titles containing the search term
        OR a.Name LIKE '%' + @SearchTerm + '%' -- Or search for books with authors' names containing the search term
END;
