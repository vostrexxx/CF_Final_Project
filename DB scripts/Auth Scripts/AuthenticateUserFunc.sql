-- Altering the function 'AuthenticateUserFunc'
ALTER FUNCTION AuthenticateUserFunc
(
    -- Parameters: Phone number and OTP code
    @PhoneNumber VARCHAR(20),
    @OTPCode VARCHAR(10)
)
-- The function returns a BIT indicating the authentication status
RETURNS BIT
AS
BEGIN
    -- Declare a variable to hold the validity status
    DECLARE @IsValid BIT;
    -- Check if there exists a user with the given phone number and OTP code
    IF EXISTS (SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber AND OTPCode = @OTPCode)
        SET @IsValid = 1; -- If user exists, set validity to true (1)
    ELSE
        SET @IsValid = 0; -- If user does not exist, set validity to false (0)

    -- Return the validity status
    RETURN @IsValid;
END;