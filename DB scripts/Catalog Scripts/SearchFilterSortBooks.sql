CREATE PROCEDURE [dbo].[SearchFilterSortBooks]
(
    @SearchTerm NVARCHAR(255) = NULL, -- Optional parameter for search term
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
    SELECT 
        b.BookID -- Selects the book ID
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID -- Joins with the Authors table on author ID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID -- Joins with the Genres table on genre ID
    LEFT JOIN
        Favorites f ON b.BookID = f.BookID AND f.UserID = @UserID -- Left joins with the Favorites table to find favorite books
    WHERE 
        (@SearchTerm IS NULL OR b.Title LIKE '%' + @SearchTerm + '%' OR a.Name LIKE '%' + @SearchTerm + '%') -- Filters by search term if provided
        AND (@AuthorID IS NULL OR b.AuthorID = @AuthorID) -- Filters by author ID if provided
        AND (@GenreID IS NULL OR b.GenreID = @GenreID) -- Filters by genre ID if provided
        AND (@MinPrice IS NULL OR b.Price >= @MinPrice) -- Filters by minimum price if provided
        AND (@MaxPrice IS NULL OR b.Price <= @MaxPrice) -- Filters by maximum price if provided
        AND (@IsFavorite IS NULL OR (f.UserID IS NOT NULL AND @IsFavorite = 1)) -- Filters by favorite status if provided
        AND (@UserID IS NULL OR f.UserID = @UserID) -- Filters by user ID if provided
    ORDER BY 
        CASE WHEN @SortBy = 'Title' AND @SortOrder = 'ASC' THEN b.Title END ASC, -- Sorts by title in ascending order if 'Title' and 'ASC' are selected
        CASE WHEN @SortBy = 'Title' AND @SortOrder = 'DESC' THEN b.Title END DESC, -- Sorts by title in descending order if 'Title' and 'DESC' are selected
        CASE WHEN @SortBy = 'Price' AND @SortOrder = 'ASC' THEN b.Price END ASC, -- Sorts by price in ascending order if 'Price' and 'ASC' are selected
        CASE WHEN @SortBy = 'Price' AND @SortOrder = 'DESC' THEN b.Price END DESC; -- Sorts by price in descending order if 'Price' and 'DESC' are selected
END;
