﻿use CF_BookStore_VNE;

-- AUTH 
EXEC AuthenticateUserProc @PhoneNumber = '1234567890', @OTPCode = '123456';
EXEC SetOTPCode @PhoneNumber = '1234567890', @OTPCode = '123457';
EXEC AuthenticateUserProc @PhoneNumber = '1234567890', @OTPCode = '123456';
EXEC AuthenticateUserProc @PhoneNumber = '1234567890', @OTPCode = '123457';
DECLARE @PhoneNumber VARCHAR(20) = '1234567890';
DECLARE @OTPCode VARCHAR(10) = '123458';
IF dbo.AuthenticateUserFunc(@PhoneNumber, @OTPCode) = 1
    PRINT 'Authentication successful';
ELSE
    PRINT 'Authentication failed';

-- CART
EXEC ViewCart @UserID = 2;
EXEC AddToCart @UserID = 2, @BookID = 3, @Quantity = 1;
EXEC ViewCart @UserID = 2;
EXEC RemoveFromCart @UserID = 2, @BookID = 3, @Quantity = 1;
EXEC ViewCart @UserID = 2;						

-- FAVORITES
EXEC ViewFavorites @UserID = 1;
EXEC AddToFavorite @UserID = 1, @BookID = 4;
EXEC ViewFavorites @UserID = 1;
EXEC RemoveFromFavorite @UserID = 1, @BookID = 1;
EXEC ViewFavorites @UserID = 1;

-- BOOK DETAILS
SELECT * FROM dbo.GetBookDetails(1);

-- SEARCHING FOR TITLE OR AUTHOR
EXEC [dbo].[SearchBooksByTitleOrAuthor] @SearchTerm = 'our';

-- CATALOG
EXEC ViewCatalogProc;
-- SORT N FILT
EXEC GetBookCatalogFilters @SortBy = 'Price', @SortOrder = 'ASC', @AuthorID = 1;;
