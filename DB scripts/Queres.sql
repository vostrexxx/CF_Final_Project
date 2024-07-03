-- Usage scenario for the AuthenticateUserFunc function
DECLARE @IsValid BIT;
SET @IsValid = dbo.AuthenticateUserFunc('1234567890', '5678');
PRINT @IsValid; -- 1 if the user is authenticated, otherwise 0
SELECT  * FROM Users;
-- Usage scenario for the SetOTPCode procedure
DECLARE @Success BIT;
DECLARE @Message NVARCHAR(255);
EXEC SetOTPCode '1234567899212', '5678', @Success OUTPUT, @Message OUTPUT;
PRINT @Success; -- 1 if the OTP code is set successfully, otherwise 0
PRINT @Message; -- Message about the operation result

-- Usage scenario for the AddToCart procedure
DECLARE @Success BIT, @Message NVARCHAR(255);
EXEC AddToCart 0, 1, 1, @Success OUTPUT, @Message OUTPUT;
SELECT @Success AS Success, @Message AS Message;

-- Usage scenario for the RemoveFromCart procedure
DECLARE @Success BIT;
DECLARE @Message NVARCHAR(255);
EXEC RemoveFromCart 1, 1, 1, @Success OUTPUT, @Message OUTPUT; -- Remove 1 copy of the book with ID 101 from the cart of the user with ID 1
PRINT @Success; -- 1 if the removal is successful, otherwise 0
PRINT @Message; -- Message about the operation result

-- Usage scenario for the ViewCart procedure
EXEC ViewCart 1; -- View the contents of the cart of the user with ID 1
EXEC ViewCart 0; -- View the contents of the cart of the user with ID 0

-- Usage scenario for the GetBookDetails function
SELECT * FROM dbo.GetBookDetails(1, 1); -- Get the details of the book with ID 1

-- Usage scenario for the SearchBooksByTitleOrAuthor procedure
EXEC SearchBooksByTitleOrAuthor 'ONE'; -- Search for books by title or author "One"

-- Usage scenario for the ViewCatalogWFiltersSort procedure
EXEC ViewCatalogWFiltersSort @MinPrice = 10, @SortBy = 'Price', @SortOrder = 'DESC';
EXEC ViewCatalogWFiltersSort;

-- Usage scenario for the AddToFavorite procedure
DECLARE @Success BIT;
DECLARE @Message NVARCHAR(255);
EXEC AddToFavorite 4, 1, @Success OUTPUT, @Message OUTPUT; -- Add the book with ID 4 to the favorites of the user with ID 1
PRINT @Success; -- 1 if the addition is successful, otherwise 0
PRINT @Message; -- Message about the operation result

-- Usage scenario for the RemoveFromFavorite procedure
DECLARE @Success BIT;
DECLARE @Message NVARCHAR(255);
EXEC RemoveFromFavorite 1, 1, @Success OUTPUT, @Message OUTPUT; -- Remove the book with ID 101 from the favorites of the user with ID 1
PRINT @Success; -- 1 if the removal is successful, otherwise 0
PRINT @Message; -- Message about the operation result

-- Usage scenario for the ViewFavorites procedure
EXEC ViewFavorites 1; -- View the favorites of the user with ID 1
