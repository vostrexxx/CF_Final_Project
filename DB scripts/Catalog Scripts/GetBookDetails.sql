ALTER FUNCTION dbo.GetBookDetails(@UserID INT, @BookID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        b.Title AS BookTitle, -- Название книги
        a.Name AS AuthorName, -- Имя автора
        g.GenreName AS Genre, -- Жанр книги
        b.Price, -- Цена книги
        b.PublicationYear, -- Год публикации
        b.PageCount, -- Количество страниц
        b.BindingType, -- Тип переплета
        b.CoverImage, -- Изображение обложки
        CASE WHEN cb.BookID IS NOT NULL THEN 1 ELSE 0 END AS InCart, -- Содержится ли в корзине
        CASE WHEN f.BookID IS NOT NULL THEN 1 ELSE 0 END AS IsFavorite -- Содержится ли в избранном
    FROM 
        Books b
    INNER JOIN
        Authors a ON b.AuthorID = a.AuthorID
    INNER JOIN
        Genres g ON b.GenreID = g.GenreID
    LEFT JOIN
        CartBooks cb ON b.BookID = cb.BookID AND cb.CartID = (SELECT CartID FROM Cart WHERE UserID = @UserID)
    LEFT JOIN
        Favorites f ON b.BookID = f.BookID AND f.UserID = @UserID
    WHERE
        b.BookID = @BookID
);
