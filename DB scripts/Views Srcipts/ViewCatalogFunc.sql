ALTER PROCEDURE dbo.GetBookCatalogFilters
(
    @AuthorID INT = NULL,
    @GenreID INT = NULL,
    @MinPrice DECIMAL(10, 2) = NULL,
    @MaxPrice DECIMAL(10, 2) = NULL,
    @UserID INT = NULL,
    @IsFavorite BIT = NULL
)
AS
BEGIN
    SELECT 
        b.Title AS Book_Title,
        a.Name AS Author,
        g.GenreName AS Genre,
        b.Price,
        b.CoverImage AS Cover_Image,
        CASE WHEN f.UserID IS NOT NULL THEN 1 ELSE 0 END AS IsFavorite
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID
    LEFT JOIN
        Favorites f ON b.BookID = f.BookID AND f.UserID = @UserID
    WHERE 
        (@AuthorID IS NULL OR b.AuthorID = @AuthorID)
        AND (@GenreID IS NULL OR b.GenreID = @GenreID)
        AND (@MinPrice IS NULL OR b.Price >= @MinPrice)
        AND (@MaxPrice IS NULL OR b.Price <= @MaxPrice)
        AND (@IsFavorite IS NULL OR (f.UserID IS NOT NULL AND @IsFavorite = 1))
        AND (@UserID IS NULL OR f.UserID = @UserID)
END;
GO
