CREATE PROCEDURE AuthenticateUserProc
    @PhoneNumber VARCHAR(20),
    @OTPCode VARCHAR(10)
AS
BEGIN
    -- Проверка наличия пользователя с заданным номером телефона и кодом OTP
    IF EXISTS (SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber AND OTPCode = @OTPCode)
    BEGIN
        -- Успешная аутентификация
        PRINT 'User authenticated successfully.';
        SELECT 1 AS Authenticated;
    END
    ELSE
    BEGIN
        -- Неудачная аутентификация
        PRINT 'Authentication failed. Invalid phone number or OTP code.';
        SELECT 0 AS Authenticated;
    END
END;
