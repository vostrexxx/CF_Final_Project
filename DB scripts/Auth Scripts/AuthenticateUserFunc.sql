ALTER FUNCTION AuthenticateUserFunc
(
    @PhoneNumber VARCHAR(20),
    @OTPCode VARCHAR(10)
)
RETURNS BIT
AS
BEGIN
    DECLARE @IsValid BIT;

    -- Проверка наличия пользователя с заданным номером телефона и OTP кодом
    IF EXISTS (SELECT 1 FROM Users WHERE PhoneNumber = @PhoneNumber AND OTPCode = @OTPCode)
        SET @IsValid = 1; -- Пользователь аутентифицирован успешно
    ELSE
        SET @IsValid = 0; -- Пользователь не аутентифицирован

    RETURN @IsValid;
END;
