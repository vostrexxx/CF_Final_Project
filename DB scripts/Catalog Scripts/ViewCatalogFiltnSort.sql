USE [CF_BookStore_VNE]
GO

/****** Object:  StoredProcedure [dbo].[GetBookCatalogFilters]    Script Date: 28.06.2024 22:12:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Alters the existing stored procedure [dbo].[GetBookCatalogFilters]
CREATE PROCEDURE ViewCatalogWFiltersSort
(
    @AuthorID INT = NULL, -- Optional parameter for filtering by author ID
    @GenreID INT = NULL, -- Optional parameter for filtering by genre ID
    @MinPrice DECIMAL(10, 2) = NULL, -- Optional parameter for setting minimum price filter
    @MaxPrice DECIMAL(10, 2) = NULL, -- Optional parameter for setting maximum price filter
    @UserID INT = NULL, -- Optional parameter for identifying user ID
    @IsFavorite BIT = NULL, -- Optional parameter to filter only favorite books
    @SortBy NVARCHAR(50) = 'Title', -- Parameter to choose sorting by 'Title' or 'Price'
    @SortOrder NVARCHAR(4) = 'ASC' -- Parameter to choose sorting order 'ASC' or 'DESC'
)
AS
BEGIN
    -- Define the base query with required joins and columns
    SELECT 
        b.Title AS Book_Title, -- Selects the book title
        a.Name AS Author, -- Selects the author's name
        g.GenreName AS Genre, -- Selects the genre name
        b.Price, -- Selects the book price
        b.CoverImage AS Cover_Image, -- Selects the cover image of the book
        CASE WHEN f.UserID IS NOT NULL THEN 1 ELSE 0 END AS IsFavorite -- Determines if the book is marked as favorite
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID -- Joins with the Authors table on author ID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID -- Joins with the Genres table on genre ID
    LEFT JOIN
        Favorites f ON b.BookID = f.BookID AND f.UserID = @UserID -- Left joins with the Favorites table to find favorite books
    WHERE 
        (@AuthorID IS NULL OR b.AuthorID = @AuthorID) -- Filters by author ID if provided
        AND (@GenreID IS NULL OR b.GenreID = @GenreID) -- Filters by genre ID if provided
        AND (@MinPrice IS NULL OR b.Price >= @MinPrice) -- Filters by minimum price if provided
        AND (@MaxPrice IS NULL OR b.Price <= @MaxPrice) -- Filters by maximum price if provided
        AND (@IsFavorite IS NULL OR (f.UserID IS NOT NULL AND @IsFavorite = 1)) -- Filters by favorite status if provided
        AND (@UserID IS NULL OR f.UserID = @UserID) -- Filters by user ID if provided
    -- Apply sorting based on the input parameters
    ORDER BY 
        CASE WHEN @SortBy = 'Title' THEN b.Title END ASC, -- Sorts by title in ascending order if 'Title' is selected
        CASE WHEN @SortBy = 'Price' THEN b.Price END ASC, -- Sorts by price in ascending order if 'Price' is selected
        CASE WHEN @SortOrder = 'DESC' THEN b.Title END DESC, -- Sorts by title in descending order if 'DESC' is selected
        CASE WHEN @SortOrder = 'DESC' THEN b.Price END DESC; -- Sorts by price in descending order if 'DESC' is selected
END;
GO