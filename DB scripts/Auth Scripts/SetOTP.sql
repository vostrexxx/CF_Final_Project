ALTER PROCEDURE SetOTPCode
    -- Parameters: Phone number and OTP code
    @PhoneNumber VARCHAR(20),
    @OTPCode VARCHAR(10),
    -- Output parameter to track success
    @Success BIT OUTPUT,
    -- Output parameter for the message
    @Message NVARCHAR(255) OUTPUT
AS
BEGIN
    -- Initialize as unsuccessful
    SET @Success = 0;
    -- Initialize error message
    SET @Message = 'Operation failed.';

    -- Check if a user with the given phone number exists
    IF NOT EXISTS (SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber)
    BEGIN
        -- If user does not exist, set error message
        SET @Message = 'User with phone number ' + @PhoneNumber + ' does not exist.';
        RETURN;
    END

    -- Update the OTP code for the specified user
    UPDATE Users
    SET OTPCode = @OTPCode
    WHERE PhoneNumber = @PhoneNumber;

    -- If execution reaches this point, the operation was successful
    -- Set as successful
    SET @Success = 1;
    -- Set success message
    SET @Message = 'OTP code set successfully for user with phone number ' + @PhoneNumber + '.';
END;
