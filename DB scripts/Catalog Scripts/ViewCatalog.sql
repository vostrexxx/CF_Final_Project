ALTER PROCEDURE ViewCatalogProc
AS
BEGIN
    SELECT
        b.Title AS Book_Title, -- The title of the book
        a.Name AS Author, -- The name of the author
        b.Price, -- The price of the book
        b.CoverImage AS Cover_Image -- The cover image of the book
    FROM
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    -- The JOIN with Genres g is unnecessary since genre information is not selected or used in a filter.
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID;
END;
