ALTER PROCEDURE ViewCatalogProc
AS
BEGIN
    SELECT
        b.Title AS Book_Title,
        a.Name AS Author,
        b.Price,
        b.CoverImage AS Cover_Image
    FROM
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID;
END;