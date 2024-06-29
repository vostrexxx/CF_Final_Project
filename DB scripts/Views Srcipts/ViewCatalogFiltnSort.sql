USE [CF_BookStore_VNE]
GO

/****** Object:  StoredProcedure [dbo].[GetBookCatalogFilters]    Script Date: 28.06.2024 22:12:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[GetBookCatalogFilters]
(
    @AuthorID INT = NULL,
    @GenreID INT = NULL,
    @MinPrice DECIMAL(10, 2) = NULL,
    @MaxPrice DECIMAL(10, 2) = NULL,
    @UserID INT = NULL,
    @IsFavorite BIT = NULL,
    @SortBy NVARCHAR(50) = 'Title', -- 'Title' или 'Price'
    @SortOrder NVARCHAR(4) = 'ASC' -- 'ASC' или 'DESC'
)
AS
BEGIN
    DECLARE @SQL NVARCHAR(MAX)

    SET @SQL = N'SELECT 
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
                    AND (@UserID IS NULL OR f.UserID = @UserID) '

    IF @SortBy = 'Title'
    BEGIN
        SET @SQL = @SQL + N' ORDER BY b.Title ' + @SortOrder
    END
    ELSE IF @SortBy = 'Price'
    BEGIN
        SET @SQL = @SQL + N' ORDER BY b.Price ' + @SortOrder
    END

    EXEC sp_executesql @SQL,
                       N'@AuthorID INT, @GenreID INT, @MinPrice DECIMAL(10, 2), @MaxPrice DECIMAL(10, 2), @UserID INT, @IsFavorite BIT',
                       @AuthorID, @GenreID, @MinPrice, @MaxPrice, @UserID, @IsFavorite
END;
GO
