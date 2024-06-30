CREATE FUNCTION dbo.GetBookDetails(@BookID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        b.Title AS BookTitle, -- The title of the book
        a.Name AS AuthorName, -- The name of the author
        g.GenreName AS Genre, -- The genre of the book
        b.Price, -- The price of the book
        b.PublicationYear, -- The year the book was published
        b.PageCount, -- The number of pages in the book
        b.BindingType, -- The type of binding of the book
        b.CoverImage -- The cover image of the book
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID
    WHERE
        b.BookID = @BookID
);
