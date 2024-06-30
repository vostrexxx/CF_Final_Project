-- Altering the procedure 'ViewCart'
ALTER PROCEDURE ViewCart
    -- Parameter: User ID
    @UserID INT
AS
BEGIN
    -- Ensure there are no open cursors and drop temporary tables if they exist
    IF OBJECT_ID('tempdb..#CartDetails') IS NOT NULL
    BEGIN
        DROP TABLE #CartDetails;
    END
    
    -- Check if a user with the given UserID exists
    IF NOT EXISTS (SELECT 1 FROM Users WHERE UserID = @UserID)
    BEGIN
        -- If user does not exist, print an error message and exit
        PRINT 'UserID ' + CAST(@UserID AS VARCHAR(10)) + ' does not exist.';
        RETURN;
    END

    -- Create a temporary table to store the results
    CREATE TABLE #CartDetails (
        Title VARCHAR(100),
        Author VARCHAR(100),
        Price DECIMAL(10, 2),
        Quantity INT,
        TotalPrice DECIMAL(10, 2)
    );

    -- Insert data into the temporary table
    INSERT INTO #CartDetails
    SELECT 
        b.Title,
        a.Name AS Author,
        b.Price,
        cb.Quantity,
        (b.Price * cb.Quantity) AS TotalPrice
    FROM 
        Cart c
    JOIN 
        CartBooks cb ON c.CartID = cb.CartID
    JOIN 
        Books b ON cb.BookID = b.BookID
    JOIN
        Authors a ON b.AuthorID = a.AuthorID
    WHERE 
        c.UserID = @UserID;

    -- Return the results
    SELECT * FROM #CartDetails;

    -- Drop the temporary table
    DROP TABLE #CartDetails;
END;
